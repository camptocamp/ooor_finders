Following behaviors are added

find_by_XX
find_first_by_XX
find_all_by_XX
find_last_by_XX
+
find_by_xml_id or alias find_by_oid

So we can do

require "ooor_finders"

ResUsers.find_by_xml_id('module.xml_id').id
ResUsers.find_by_id(23).id
ResUsers.find_by_name('Administrator').id
ResUsers.find_by_name!('Administrator').id Will throw an exception if you put a ! at the end

We can also do:
ResUsers.find_all_by_name('Administrator')
ResUsers.find_last_by_name('Administrator')
ResUsers.find_last_by_name_and_login('Administrator', 'admin')
ResUsers.find_by_name_and_login('Administrator', 'admin')

Plus the create mode 

ResUsers.find_or_create_by_login_and_name_and_oid 'toto', 'toto', 'base.toto'
ResUsers.find_or_create_by_login_and_name'toto', 'toto'

Other options are supported

ResUsers.find_all_by_name('Administrator', :fields=>['id'], :limit=>20)