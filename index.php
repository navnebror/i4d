<?php
    require_once(__DIR__.'/config/config.php');
    require_once(__DIR__.'/config/sql.php');
    error_reporting(-1);
    //Referencia: http://help.slimframework.com/discussions/problems/2446-class-slim-not-found
    //use lib\Slim\Slim;
    require_once(__DIR__.'/lib/3party/Slim/Slim.php');
    \Slim\Slim::registerAutoloader();

    require_once(__DIR__.'/lib/3party/meekrodb-2.4/db.class.php');

    ini_set("memory_limit","512M");
    ini_set('log_errors_max_len', '65535');

    $app = new \Slim\Slim();

    $app->response()->header('Content-Type', 'application/json');

    $db = new MeekroDB(DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT);
    
    //Para el caso de las peticiones que generan caché, borrar el archivo cuando finalize la petición
    $app->hook('slim.after', function() use ($app){
        //CacheUtils::delete();
    });

    $app->group('/v1', function() use ($app, $db){

        $app->get('/patients/', function () use ($app, $db){
            $res = $db->query(SQL_SELECT_ALL_PATIENTS);
            $res = json_encode($res, JSON_PRETTY_PRINT);
	    $app->response->headers->set('Access-Control-Allow-Origin', '*');
            $app->response()->write($res);
        });

        $app->get('/patients/id/:id/', function ($id) use ($app, $db){
            //$res = $db->query(SQL_SELECT_PATIENTS_ONE, 'CC', $id);
            $res = $db->query(SQL_SELECT_PATIENTS_ONE, $id);
            $res = json_encode($res, JSON_PRETTY_PRINT);
	    $app->response->headers->set('Access-Control-Allow-Origin', '*');
            $app->response()->write($res);
        });

	$app->get('/patients/id/:id/type/:type', function ($id, $type) use ($app, $db){
            $res = $db->query(SQL_SELECT_PATIENTS_ONE, $type, $id);
            $res = json_encode($res, JSON_PRETTY_PRINT);
            $app->response->headers->set('Access-Control-Allow-Origin', '*');
            $app->response()->write($res);
        });

        $app->get('/patients/id/:id/history/', function ($id) use ($app, $db){
            $res = $db->query(SQL_SELECT_BY_PATIENT_ALL, 'CC', $id);
            $res = json_encode($res, JSON_PRETTY_PRINT);
	    $app->response->headers->set('Access-Control-Allow-Origin', '*');
            $app->response()->write($res);
        });

        $app->get('/risk_factors/sugar/:sugar/fat/:fat/oxygen/:oxygen/', function ($sugar, $fat, $oxygen) use ($app, $db){
            $res  = $db->query(SQL_SELECT_RISK_FACTOR, $sugar, $fat, $oxygen);

            //La lógica de validar si un parámetro (ej: azúcar) está bien y otro es de negocio
            //por lo tanto no queda en la base de datos sino acá en la capa de integración
            $riskFactor = 'UNDEFINED';
            $count = count(array_keys($res));

            if($count !== 1){
                $res = array($res[0]);
                $res[0]['risk_factor'] = $riskFactor;
            }

            $res = json_encode($res, JSON_PRETTY_PRINT);
	    $app->response->headers->set('Access-Control-Allow-Origin', '*');
            $app->response()->write($res);
        });

    });

    $app->run();



?>
