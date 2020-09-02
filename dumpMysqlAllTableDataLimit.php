<?php
set_time_limit(0);

$dbname = "table";

$con = mysqli_connect("127.0.0.1", "root", "123456", $dbname, '3306');

if ($con) {
    if (mysqli_select_db($con, $dbname)) {
        $sql = "SHOW TABLES WHERE Tables_in_$dbname not  LIKE '%0%';";
        $ret = mysqli_query($con, $sql);
        while ($row = mysqli_fetch_assoc($ret)) {
            $info1[] = $row["Tables_in_$dbname"];
        }
        foreach ($info1 as $val) {

            $result = [];
            $_tmpRes = @mysqli_query($con, "select * from `" . $val . "` limit 5000");
            if (!$_tmpRes) die("SQL(fetchRow):{$sql} " . mysqli_error($con));
            while ($res = mysqli_fetch_assoc($_tmpRes)) {
                $result[] = $res;
            }
//
            $tmp_value = "";
            $tmp_key = "";
            if (!empty($result)) {
                foreach ($result as $key => $value) {
                    $tmp_key = '(`' . implode('`,`', array_keys($value)) . '`) values ';
                    $tmp_value .= "('" . implode("','", array_values($value)) . "'),";
                }
                $sql = "insert into `" . $val . "`" . $tmp_key . $tmp_value;
                $sql = substr($sql, 0, -1) . ";\r\n";
            }
            file_put_contents("./dump_" . $dbname . ".sql", $sql, FILE_APPEND);
            var_dump($val);
        }
    }
}

echo "END!";
