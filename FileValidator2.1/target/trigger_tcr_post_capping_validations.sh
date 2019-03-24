run_id=$1
country_id=$2
partitions=$3
input_paths=$4
output_paths=$5
remote_location=$6


currentdate=`date +'%d%m%Y'`

echo $run_id"-"$country_id"-"$partitions"-"$input_paths"-"$output_paths"-"remote_location


spark2-submit --class com.nielsen.tcr.scalaFunctions.Trigger $remote_location/tcrFunctions-0.0.1-SNAPSHOT.jar run_id $run_id country_id $country_id partitions $partitions input_paths $input_paths output_paths $output_paths remote_location $remote_location 2> $remote_location/post_capping_validation_log_$currentdate.log

returncode=$?
echo "returncode"$returncode

if [ $returncode == 0 ]
then
echo "Postcapping Counts validations done successfully"
else
echo "**Error occured in Postcapping count validations**" $returncode
err_result=`cat $remote_location/post_capping_validation_log_$currentdate.log | grep ERROR `
echo "Error Info : $err_result "

exit 1
fi