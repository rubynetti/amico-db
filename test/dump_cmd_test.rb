require 'test_helper'
class DumpCmdTest  < Minitest::Test
  def test_return_mysql_dump_command
    result = AmicoDb::DumpCmd.new.call
    assert_equal "cd /var/www/yourproject; " +
                 "docker-compose exec -T db " +
                 "bash -c " +
                 "'mysqldump -u dbusername " +
                 "--ignore-table=dbname.ar_internal_metadata " +
                 "--no-create-db -p$MYSQL_ROOT_PASSWORD dbname > /dumps/db.sql'",
                 result
  end
end
