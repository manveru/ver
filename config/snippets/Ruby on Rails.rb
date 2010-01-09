# Encoding: UTF-8

{"ft" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_tag",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_INLINE}form_tag(${1::action => \"${5:update}\"}${6:, {:${8:class} => \"${9:form}\"\\}}) do${TM_RAILS_TEMPLATE_END_RUBY_EXPR}\n  $0\n${TM_RAILS_TEMPLATE_END_RUBY_BLOCK}"},
 "mcol" => 
  {scope: 
    "meta.rails.migration - meta.rails.migration.create_table - meta.rails.migration.change_table",
   name: "Remove / Add Column",
   content: 
    "remove_column :${1:table}, :${2:column}${3: [press tab twice to generate add_column]}"},
 "mccc" => 
  {scope: "meta.rails.migration.create_table",
   name: "Create Several Columns in Table",
   content: "t.column ${1:title}, :${2:string}\nmccc$0"},
 "mtab" => 
  {scope: 
    "meta.rails.migration - meta.rails.migration.create_table - meta.rails.migration.change_table",
   name: "Drop / Create Table",
   content: 
    "drop_table :${1:table}${2: [press tab twice to generate create_table]}"},
 "rdb" => 
  {scope: "source.ruby.rails",
   name: "RAILS_DEFAULT_LOGGER.debug",
   content: "RAILS_DEFAULT_LOGGER.debug \"${1:message}\"$0"},
 "art" => 
  {scope: "source.ruby.rails",
   name: "assert_redirected_to",
   content: "assert_redirected_to ${2::action => \"${1:index}\"}"},
 "asre" => 
  {scope: "source.ruby.rails",
   name: "assert_response",
   content: "assert_response :${1:success}, @response.body$0"},
 "bt" => 
  {scope: "source.ruby.rails",
   name: "belongs_to",
   content: 
    "belongs_to :${1:object}${2:, :class_name => \"${3:${1/[[:alpha:]]+|(_)/(?1::\\u$0)/g}}\", :foreign_key => \"${4:${1}_id}\"}"},
 "habtm" => 
  {scope: "source.ruby.rails",
   name: "has_and_belongs_to_many",
   content: 
    "has_and_belongs_to_many :${1:object}${2:, :join_table => \"${3:table_name}\", :foreign_key => \"${4:${1}_id}\"}"},
 "hm" => 
  {scope: "source.ruby.rails",
   name: "has_many",
   content: 
    "has_many :${1:object}s${2:, :class_name => \"${1}\", :foreign_key => \"${4:reference}_id\"}"},
 "ho" => 
  {scope: "source.ruby.rails",
   name: "has_one",
   content: 
    "has_one :${1:object}${2:, :class_name => \"${3:${1/[[:alpha:]]+|(_)/(?1::\\u$0)/g}}\", :foreign_key => \"${4:${1}_id}\"}"},
 "lia" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (action)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to \"${1:link text...}\", :action => \"${2:index}\"${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "liai" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (action, id)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to \"${1:link text...}\", :action => \"${2:edit}\", :id => ${3:@item}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "lic" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (controller)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to \"${1:link text...}\", :controller => \"${2:items}\"${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "lica" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (controller, action)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to \"${1:link text...}\", :controller => \"${2:items}\", :action => \"${3:index}\"${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "licai" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (controller, action, id)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to \"${1:link text...}\", :controller => \"${2:items}\", :action => \"${3:edit}\", :id => ${4:@item}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "flash" => 
  {scope: "source.ruby.rails",
   name: "flash[…]",
   content: "flash[:${1:notice}] = \"${2:Successfully created...}\"$0"},
 nil => 
  {scope: "meta.rails.controller",
   name: "respond_to (html)",
   content: 
    "respond_to do |wants|\n\twants.html do\n\t\t$TM_SELECTED_TEXT\n\tend\n\twants.${1:js} { $0 }\nend"},
 "rea" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (action)",
   content: "redirect_to :action => \"${1:index}\""},
 "reai" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (action, id)",
   content: "redirect_to :action => \"${1:show}\", :id => ${0:@item}"},
 "rec" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (controller)",
   content: "redirect_to :controller => \"${1:items}\""},
 "reca" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (controller, action)",
   content: 
    "redirect_to :controller => \"${1:items}\", :action => \"${2:list}\""},
 "recai" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (controller, action, id)",
   content: 
    "redirect_to :controller => \"${1:items}\", :action => \"${2:show}\", :id => ${0:@item}"},
 "ra" => 
  {scope: "source.ruby.rails",
   name: "render (action)",
   content: "render :action => \"${1:action}\""},
 "ral" => 
  {scope: "source.ruby.rails",
   name: "render (action, layout)",
   content: 
    "render :action => \"${1:action}\", :layout => \"${2:layoutname}\""},
 "rf" => 
  {scope: "source.ruby.rails",
   name: "render (file)",
   content: "render :file => \"${1:filepath}\""},
 "rfu" => 
  {scope: "source.ruby.rails",
   name: "render (file, use_full_path)",
   content: "render :file => \"${1:filepath}\", :use_full_path => ${2:false}"},
 "ri" => 
  {scope: "source.ruby.rails",
   name: "render (inline)",
   content: "render :inline => \"${1:<%= 'hello' %>}\""},
 "ril" => 
  {scope: "source.ruby.rails",
   name: "render (inline, locals)",
   content: 
    "render :inline => \"${1:<%= 'hello' %>}\", :locals => { ${2::name} => \"${3:value}\"$4 }"},
 "rit" => 
  {scope: "source.ruby.rails",
   name: "render (inline, type)",
   content: "render :inline => \"${1:<%= 'hello' %>}\", :type => ${2::rxml}"},
 "rl" => 
  {scope: "source.ruby.rails",
   name: "render (layout)",
   content: "render :layout => \"${1:layoutname}\""},
 "rn" => 
  {scope: "source.ruby.rails",
   name: "render (nothing)",
   content: "render :nothing => ${1:true}"},
 "rns" => 
  {scope: "source.ruby.rails",
   name: "render (nothing, status)",
   content: "render :nothing => ${1:true}, :status => ${2:401}"},
 "rp" => 
  {scope: "source.ruby.rails",
   name: "render (partial)",
   content: "render :partial => \"${1:item}\""},
 "rpc" => 
  {scope: "source.ruby.rails",
   name: "render (partial, collection)",
   content: "render :partial => \"${1:item}\", :collection => ${2:@$1s}"},
 "rpl" => 
  {scope: "source.ruby.rails",
   name: "render (partial, locals)",
   content: 
    "render :partial => \"${1:item}\", :locals => { :${2:$1} => ${3:@$1}$0 }"},
 "rpo" => 
  {scope: "source.ruby.rails",
   name: "render (partial, object)",
   content: "render :partial => \"${1:item}\", :object => ${2:@$1}"},
 "rps" => 
  {scope: "source.ruby.rails",
   name: "render (partial, status)",
   content: "render :partial => \"${1:item}\", :status => ${2:500}"},
 "rt" => 
  {scope: "source.ruby.rails",
   name: "render (text)",
   content: "render :text => \"${1:text to render...}\""},
 "rtl" => 
  {scope: "source.ruby.rails",
   name: "render (text, layout)",
   content: 
    "render :text => \"${1:text to render...}\", :layout => \"${2:layoutname}\""},
 "rtlt" => 
  {scope: "source.ruby.rails",
   name: "render (text, layout => true)",
   content: 
    "render :text => \"${1:text to render...}\", :layout => ${2:true}"},
 "rts" => 
  {scope: "source.ruby.rails",
   name: "render (text, status)",
   content: "render :text => \"${1:text to render...}\", :status => ${2:401}"},
 "va" => 
  {scope: "source.ruby.rails",
   name: "validates_associated",
   content: "validates_associated :${1:attribute}${2:, :on => :${3:create}}"},
 "vaif" => 
  {scope: "source.ruby.rails",
   name: "validates_associated if",
   content: 
    "validates_associated :${1:attribute}${2:, :on => :${3:create}, :if => proc { |obj| ${5:obj.condition?} }}"},
 "vc" => 
  {scope: "source.ruby.rails",
   name: "validates_confirmation_of",
   content: 
    "validates_confirmation_of :${1:attribute}${2:, :on => :${3:create}, :message => \"${4:should match confirmation}\"}"},
 "vcif" => 
  {scope: "source.ruby.rails",
   name: "validates_confirmation_of if",
   content: 
    "validates_confirmation_of :${1:attribute}${2:, :on => :${3:create}, :message => \"${4:should match confirmation}\", :if => proc { |obj| ${5:obj.condition?} }}"},
 "ve" => 
  {scope: "source.ruby.rails",
   name: "validates_exclusion_of",
   content: 
    "validates_exclusion_of :${1:attribute}${2:, :in => ${3:%w( ${4:mov avi} )}, :on => :${5:create}, :message => \"${6:extension %s is not allowed}\"}"},
 "veif" => 
  {scope: "source.ruby.rails",
   name: "validates_exclusion_of if",
   content: 
    "validates_exclusion_of :${1:attribute}${2:, :in => ${3:%w( ${4:mov avi} )}, :on => :${5:create}, :message => \"${6:extension %s is not allowed}\"}, :if => proc { |obj| ${7:obj.condition?} }}"},
 "vl" => 
  {scope: "source.ruby.rails",
   name: "validates_length_of",
   content: 
    "validates_length_of :${1:attribute}, :within => ${2:3..20}${3:, :on => :${4:create}, :message => \"${5:must be present}\"}"},
 "vp" => 
  {scope: "source.ruby.rails",
   name: "validates_presence_of",
   content: 
    "validates_presence_of :${1:attribute}${2:, :on => :${3:create}, :message => \"${4:can't be blank}\"}"},
 "vpif" => 
  {scope: "source.ruby.rails",
   name: "validates_presence_of if",
   content: 
    "validates_presence_of :${1:attribute}${2:, :on => :${3:create}, :message => \"${4:can't be blank}\"}, :if => proc { |obj| ${5:obj.condition?} }}"},
 "vu" => 
  {scope: "source.ruby.rails",
   name: "validates_uniqueness_of",
   content: 
    "validates_uniqueness_of :${1:attribute}${2:, :on => :${3:create}, :message => \"${4:must be unique}\"}"},
 "vuif" => 
  {scope: "source.ruby.rails",
   name: "validates_uniqueness_of if",
   content: 
    "validates_uniqueness_of :${1:attribute}${2:, :on => :${3:create}, :message => \"${4:must be unique}\", :if => proc { |obj| ${6:obj.condition?} }}"},
 "verify" => 
  {scope: "source.ruby.rails",
   name: "verify — redirect",
   content: 
    "verify :only => [:$1], :session => :user, :params => :id, :redirect_to => {:action => '${2:index}'}\n"},
 "$L" => {scope: "source.yaml", name: "$LABEL", content: "\\$LABEL"},
 "fi" => 
  {scope: "source.yaml",
   name: "<%= Fixtures.identify(:symbol) %>",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}Fixtures.identify(:${1:name})${TM_RAILS_TEMPLATE_END_RUBY_EXPR}$0"},
 "tcbi" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column binary",
   content: "t.binary :${1:title}${2:, :limit => ${3:2}.megabytes}\n$0"},
 "tcb" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column boolean",
   content: "t.boolean :${1:title}\n$0"},
 "cla" => 
  {scope: "source.ruby",
   name: "Create functional test class",
   content: 
    "require File.dirname(__FILE__) + '/../test_helper'\n\nclass ${1:Model}ControllerTest < ActionController::TestCase\n\tdeft$0\nend\n"},
 "tcda" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column date",
   content: "t.date :${1:title}\n$0"},
 "tcdt" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column datetime",
   content: "t.datetime :${1:title}\n$0"},
 "tcd" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column decimal",
   content: 
    "t.decimal :${1:title}${2:${3:, :precision => ${4:10}}${5:, :scale => ${6:2}}}\n$0"},
 "tcf" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column float",
   content: "t.float :${1:title}\n$0"},
 "tci" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column integer",
   content: "t.integer :${1:title}\n$0"},
 "tcl" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column lock_version",
   content: "t.integer :lock_version, :null => false, :default => 0\n$0"},
 "tcr" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column(s) references",
   content: 
    "t.references :${1:taggable}${2:, :polymorphic => ${3:{ :default => '${4:Photo}' \\}}}\n$0"},
 "tcs" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column string",
   content: "t.string :${1:title}\n$0"},
 "tct" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column text",
   content: "t.text :${1:title}\n$0"},
 "tcti" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column time",
   content: "t.time :${1:title}\n$0"},
 "tcts" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column timestamp",
   content: "t.timestamp :${1:title}\n$0"},
 "tctss" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column timestamps",
   content: "t.timestamps\n$0"},
 "tre" => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "Table column(s) rename",
   content: "t.rename(:${1:old_column_name}, :${2:new_column_name})\n$0"},
 "aftc" => 
  {scope: "source.ruby.rails", name: "after_create", content: "after_create "},
 "aftd" => 
  {scope: "source.ruby.rails",
   name: "after_destroy",
   content: "after_destroy "},
 "afts" => 
  {scope: "source.ruby.rails", name: "after_save", content: "after_save "},
 "aftu" => 
  {scope: "source.ruby.rails", name: "after_update", content: "after_update "},
 "aftv" => 
  {scope: "source.ruby.rails",
   name: "after_validation",
   content: "after_validation "},
 "aftvoc" => 
  {scope: "source.ruby.rails",
   name: "after_validation_on_create",
   content: "after_validation_on_create "},
 "aftvou" => 
  {scope: "source.ruby.rails",
   name: "after_validation_on_update",
   content: "after_validation_on_update "},
 "asg" => 
  {scope: "source.ruby",
   name: "assert(var = assigns(:var))",
   content: "assert(${1:var} = assigns(:${1}), \"Cannot find @${1}\")\n$0"},
 "asd" => 
  {scope: "source.ruby",
   name: "assert_difference",
   content: 
    "assert_difference \"${1:Model}.${2:count}\", ${3:1} do\n  $0\nend"},
 "asnd" => 
  {scope: "source.ruby",
   name: "assert_no_difference",
   content: "assert_no_difference \"${1:Model}.${2:count}\" do\n  $0\nend"},
 "artnpp" => 
  {scope: "source.ruby.rails",
   name: "assert_redirected_to (nested path plural)",
   content: 
    "assert_redirected_to ${10:${2:parent}_${3:child}_path(${4:@}${5:${2}})}"},
 "artnp" => 
  {scope: "source.ruby.rails",
   name: "assert_redirected_to (nested path)",
   content: 
    "assert_redirected_to ${2:${12:parent}_${13:child}_path(${14:@}${15:${12}}, ${16:@}${17:${13}})}"},
 "artpp" => 
  {scope: "source.ruby.rails",
   name: "assert_redirected_to (path plural)",
   content: "assert_redirected_to ${10:${2:model}s_path}"},
 "artp" => 
  {scope: "source.ruby.rails",
   name: "assert_redirected_to (path)",
   content: "assert_redirected_to ${2:${12:model}_path(${13:@}${14:${12}})}"},
 "asrj" => 
  {scope: "source.ruby.rails",
   name: "assert_rjs",
   content: "assert_rjs :${1:replace}, ${2:\"${3:dom id}\"}"},
 "ass" => 
  {scope: "source.ruby.rails",
   name: "assert_select",
   content: 
    "assert_select '${1:path}'${2:, :${3:text} => ${4:'${5:inner_html}'}}${6: do\n\t$0\nend}"},
 "befc" => 
  {scope: "source.ruby.rails",
   name: "before_create",
   content: "before_create "},
 "befd" => 
  {scope: "source.ruby.rails",
   name: "before_destroy",
   content: "before_destroy "},
 "befs" => 
  {scope: "source.ruby.rails", name: "before_save", content: "before_save "},
 "befu" => 
  {scope: "source.ruby.rails",
   name: "before_update",
   content: "before_update "},
 "befv" => 
  {scope: "source.ruby.rails",
   name: "before_validation",
   content: "before_validation "},
 "befvoc" => 
  {scope: "source.ruby.rails",
   name: "before_validation_on_create",
   content: "before_validation_on_create "},
 "befvou" => 
  {scope: "source.ruby.rails",
   name: "before_validation_on_update",
   content: "before_validation_on_update"},
 "crw" => 
  {scope: "source.ruby.rails",
   name: "cattr_accessor",
   content: "cattr_accessor :${0:attr_names}"},
 "defcreate" => 
  {scope: "meta.rails.controller",
   name: "def create - resource",
   content: 
    "def create\n\t@${1:model} = ${2:${1/[[:alpha:]]+|(_)/(?1::\\u$0)/g}}.new(params[:$1])\n\t$0\n\trespond_to do |wants|\n\t\tif @$1.save\n\t\t\tflash[:notice] = '$2 was successfully created.'\n\t\t\twants.html { redirect_to(@$1) }\n\t\t\twants.xml { render :xml => @$1, :status => :created, :location => @$1 }\n\t\telse\n\t\t\twants.html { render :action => \"new\" }\n\t\t\twants.xml { render :xml => @$1.errors, :status => :unprocessable_entity }\n\t\tend\n\tend\nend\n"},
 "deftg" => 
  {scope: "meta.rails.functional_test",
   name: "def test_should_get_action",
   content: 
    "def test_should_get_${1:action}\n\t${2:@${3:model} = ${4:$3s}(:${5:fixture_name})\n\t}get :${1}${6:, :id => @$3.to_param}\n\tassert_response :success\n\t$0\nend"},
 "deftp" => 
  {scope: "meta.rails.functional_test",
   name: "def test_should_post_action",
   content: 
    "def test_should_post_${1:action}\n\t${3:@$2 = ${4:$2s}(:${5:fixture_name})\n\t}post :${1}${6:, :id => @$2.to_param}, :${2:model} => { $0 }\n\tassert_response :redirect\n\nend"},
 "end" => {scope: "text.html.ruby", name: "end (ERB)", content: "<% end -%>"},
 "fina" => 
  {scope: "source.ruby.rails",
   name: "find(:all)",
   content: 
    "find(:all${1:, :conditions => ['${2:${3:field} = ?}', ${5:true}]})"},
 "finf" => 
  {scope: "source.ruby.rails",
   name: "find(:first)",
   content: 
    "find(:first${1:, :conditions => ['${2:${3:field} = ?}', ${5:true}]})"},
 "fini" => 
  {scope: "source.ruby.rails", name: "find(id)", content: "find(${1:id})"},
 "for" => 
  {scope: "text.html.ruby",
   name: "for loop in rhtml",
   content: 
    "<% if !${1:list}.blank? %>\n  <% for ${2:item} in ${1} %>\n    $3\n  <% end %>\n<% else %>\n  $4\n<% end %>\n"},
 "ffcb" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for check_box",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.check_box :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "f." => 
  {scope: "text.html.ruby, text.haml",
   name: "f.text_field (fftf)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.text_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "ffff" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for file_field",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.file_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "ffhf" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for hidden_field",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.hidden_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "ffl" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for label",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.label :${1:attribute}${2:, \"${3:${1/[[:alpha:]]+|(_)/(?1: :\\u$0)/g}}\"}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "ffpf" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for password_field",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.password_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "ffrb" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for radio_box",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.radio_box :${1:attribute}, :${2:tag_value}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "ffs" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for submit",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.submit \"${1:Submit}\"${2:, :disable_with => '${3:$1ing...}'}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "ffta" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for text_area",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.text_area :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "fftf" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for text_field",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}f.text_field :${1:attribute}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "ffe" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for with errors",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}error_messages_for :${1:model}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}\n\n${TM_RAILS_TEMPLATE_START_RUBY_INLINE}form_for @${2:$1} do |f|${TM_RAILS_TEMPLATE_END_RUBY_INLINE}\n  $0\n${TM_RAILS_TEMPLATE_END_RUBY_BLOCK}"},
 "ff" => 
  {scope: "text.html.ruby, text.haml",
   name: "form_for",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_INLINE}form_for @${1:model} do |f|${TM_RAILS_TEMPLATE_END_RUBY_INLINE}\n  $0\n${TM_RAILS_TEMPLATE_END_RUBY_BLOCK}"},
 "hmt" => 
  {scope: "source.ruby.rails",
   name: "has_many (through)",
   content: 
    "has_many :${1:objects}, :through => :${2:join_association}${3:, :source => :${4:${2}_table_foreign_key_to_${1}_table}}"},
 "hmd" => 
  {scope: "source.ruby.rails",
   name: "has_many :dependent => :destroy",
   content: 
    "has_many :${1:object}s${2:, :class_name => \"${1}\", :foreign_key => \"${4:reference}_id\"}, :dependent => :destroy$0"},
 "ist" => 
  {scope: "text.html.ruby, text.haml",
   name: "image_submit_tag",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}image_submit_tag(\"${1:agree.png}\"${2:${3:, :id => \"${4:${1/^(\\w+)(\\.\\w*)?$/$1/}}\"}${5:, :name => \"${6:${1/^(\\w+)(\\.\\w*)?$/$1/}}\"}${7:, :class => \"${8:${1/^(\\w+)(\\.\\w*)?$/$1/}-button}\"}${9:, :disabled => ${10:false}}})${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "jit" => 
  {scope: "text.html.ruby",
   name: "javascript_include_tag",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}javascript_include_tag ${1::all}${2:, :cache => ${3:true}}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "linpp" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (nested path plural)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to ${1:\"${2:link text...}\"}, ${3:${10:parent}_${11:child}_path(${12:@}${13:${10}})}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "linp" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (nested path)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to ${1:\"${2:link text...}\"}, ${3:${12:parent}_${13:child}_path(${14:@}${15:${12}}, ${16:@}${17:${13}})}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "lipp" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (path plural)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to ${1:\"${2:link text...}\"}, ${3:${4:model}s_path}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "lip" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to (path)",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to ${1:\"${2:link text...}\"}, ${3:${12:model}_path(${13:@}${14:${12}})}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "lim" => 
  {scope: "text.html.ruby, text.haml",
   name: "link_to model",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}link_to ${1:model}.${2:name}, ${3:${4:$1}_path(${14:$1})}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "logd" => 
  {scope: "source.ruby.rails",
   name: "logger.debug",
   content: "logger.debug { \"${1:message}\" }$0"},
 "loge" => 
  {scope: "source.ruby.rails",
   name: "logger.error",
   content: "logger.error { \"${1:message}\" }$0"},
 "logf" => 
  {scope: "source.ruby.rails",
   name: "logger.fatal",
   content: "logger.fatal { \"${1:message}\" }$0"},
 "logi" => 
  {scope: "source.ruby.rails",
   name: "logger.info",
   content: "logger.info { \"${1:message}\" }$0"},
 "logw" => 
  {scope: "source.ruby.rails",
   name: "logger.warn",
   content: "logger.warn { \"${1:message}\" }$0"},
 "mp" => 
  {scope: "source.ruby.rails",
   name: "map(&:sym_proc)",
   content: "map(&:${1:id})"},
 "mapca" => 
  {scope: "meta.rails.routes",
   name: "map.catch_all",
   content: 
    "${1:map}.catch_all \"*${2:anything}\", :controller => \"${3:default}\", :action => \"${4:error}\"\n"},
 "map" => 
  {scope: "meta.rails.routes",
   name: "map.named_route",
   content: "${1:map}.${2:connect} '${3::controller/:action/:id}'"},
 "mapr" => 
  {scope: "meta.rails.routes",
   name: "map.resource",
   content: "${1:map}.resource :${2:resource}${10: do |${11:$2}|\n  $0\nend}"},
 "maprs" => 
  {scope: "meta.rails.routes",
   name: "map.resources",
   content: 
    "${1:map}.resources :${2:resource}${10: do |${11:$2}|\n  $0\nend}"},
 "mapwo" => 
  {scope: "meta.rails.routes",
   name: "map.with_options",
   content: 
    "${1:map}.with_options :${2:controller} => '${3:thing}' do |${4:$3}|\n\t$0\nend\n"},
 "mrw" => 
  {scope: "source.ruby.rails",
   name: "mattr_accessor",
   content: "mattr_accessor :${0:attr_names}"},
 "ncl" => 
  {scope: "source.ruby.rails",
   name: "named_scope lambda",
   content: 
    "named_scope :name, lambda { |${1:param}| { :conditions => ${3:['${4:${5:field} = ?}', ${6:$1}]} } }\n"},
 "nc" => 
  {scope: "source.ruby.rails",
   name: "named_scope",
   content: 
    "named_scope :name${1:, :joins => :${2:table}}, :conditions => ${3:['${4:${5:field} = ?}', ${6:true}]}\n"},
 "hide" => 
  {scope: "source.ruby.rails.rjs",
   name: "page.hide (*ids)",
   content: "page.hide ${1:\"${2:id(s)}\"}"},
 "ins" => 
  {scope: "source.ruby.rails.rjs",
   name: "page.insert_html (position, id, partial)",
   content: 
    "page.insert_html :${1:top}, ${2:\"${3:id}\"}, :${4:partial => \"${5:template}\"}"},
 "rep" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (path)",
   content: "redirect_to(${2:${12:model}_path(${13:@}${14:${12}})})"},
 "reph" => 
  {scope: "source.ruby.rails.rjs",
   name: "page.replace_html (id, partial)",
   content: 
    "page.replace_html ${1:\"${2:id}\"}, :${3:partial => \"${4:template}\"}"},
 "show" => 
  {scope: "source.ruby.rails.rjs",
   name: "page.show (*ids)",
   content: "page.show ${1:\"${2:id(s)}\"}"},
 "tog" => 
  {scope: "source.ruby.rails.rjs",
   name: "page.toggle (*ids)",
   content: "page.toggle ${1:\"${2:id(s)}\"}"},
 "vis" => 
  {scope: "source.ruby.rails.rjs",
   name: "page.visual_effect (effect, id)",
   content: "page.visual_effect :${1:toggle_slide}, ${2:\"${3:DOM ID}\"}"},
 "renpp" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (nested path plural)",
   content: 
    "redirect_to(${2:${10:parent}_${11:child}_path(${12:@}${13:${10}})})"},
 "renp" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (nested path)",
   content: 
    "redirect_to(${2:${12:parent}_${13:child}_path(${14:@}${15:${12}}, ${16:@}${17:${13}})})"},
 "repp" => 
  {scope: "source.ruby.rails",
   name: "redirect_to (path plural)",
   content: "redirect_to(${2:${10:model}s_path})"},
 "ru" => 
  {scope: "source.ruby.rails",
   name: "render (update)",
   content: "render :update do |${2:page}|\n\t$2.$0\nend"},
 "rest" => 
  {scope: "meta.rails.controller",
   name: "respond_to",
   content: "respond_to do |wants|\n\twants.${1:html}${2: { $0 \\}}\nend"},
 "returning" => 
  {scope: "source.ruby.rails",
   name: "returning do |variable| … end",
   content: 
    "returning ${1:variable} do${2/(^(?<var>\\s*[a-z_][a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1: |)/}${2:v}${2/(^(?<var>\\s*[a-z_][a-zA-Z0-9_]*\\s*)(,\\g<var>)*,?\\s*$)|.*/(?1:|)/}\n\t$0\nend"},
 "slt" => 
  {scope: "text.html.ruby",
   name: "stylesheet_link_tag",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}stylesheet_link_tag {1::all}${2:, :cache => ${3:true}}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "st" => 
  {scope: "text.html.ruby, text.haml",
   name: "submit_tag",
   content: 
    "${TM_RAILS_TEMPLATE_START_RUBY_EXPR}submit_tag \"${1:Save changes}\"${2:, :id => \"${3:submit}\"}${4:, :name => \"${5:$3}\"}${6:, :class => \"${7:form_$3}\"}${8:, :disabled => ${9:false}}${10:, :disable_with => \"${11:Please wait...}\"}${TM_RAILS_TEMPLATE_END_RUBY_EXPR}"},
 "t." => 
  {scope: 
    "meta.rails.migration.create_table, meta.rails.migration.change_table",
   name: "t.timestamps (tctss)",
   content: "t.timestamps\nt.$0"},
 "vaoif" => 
  {scope: "source.ruby.rails",
   name: "validates_acceptance_of if",
   content: 
    "validates_acceptance_of :${1:terms}${2:${3:, :accept => \"${4:1}\"}${5:, :message => \"${6:You must accept the terms of service}\"}}, :if => proc { |obj| ${7:obj.condition?} }}"},
 "vao" => 
  {scope: "source.ruby.rails",
   name: "validates_acceptance_of",
   content: 
    "validates_acceptance_of :${1:terms}${2:${3:, :accept => \"${4:1}\"}${5:, :message => \"${6:You must accept the terms of service}\"}}"},
 "vfif" => 
  {scope: "source.ruby.rails",
   name: "validates_format_of if",
   content: 
    "validates_format_of :${1:attribute}, :with => /${2:^[${3:\\w\\d}]+\\$}/${4:, :on => :${5:create}, :message => \"${6:is invalid}\"}, :if => proc { |obj| ${7:obj.condition?} }}"},
 "vf" => 
  {scope: "source.ruby.rails",
   name: "validates_format_of",
   content: 
    "validates_format_of :${1:attribute}, :with => /${2:^[${3:\\w\\d}]+\\$}/${4:, :on => :${5:create}, :message => \"${6:is invalid}\"}"},
 "viif" => 
  {scope: "source.ruby.rails",
   name: "validates_inclusion_of if",
   content: 
    "validates_inclusion_of :${1:attribute}${2:, :in => ${3:%w( ${4:mov avi} )}, :on => :${5:create}, :message => \"${6:extension %s is not included in the list}\"}, :if => proc { |obj| ${7:obj.condition?} }}"},
 "vi" => 
  {scope: "source.ruby.rails",
   name: "validates_inclusion_of",
   content: 
    "validates_inclusion_of :${1:attribute}${2:, :in => ${3:%w( ${4:mov avi} )}, :on => :${5:create}, :message => \"${6:extension %s is not included in the list}\"}"},
 "vlif" => 
  {scope: "source.ruby.rails",
   name: "validates_length_of if",
   content: 
    "validates_length_of :${1:attribute}, :within => ${2:3..20}${3:, :on => :${4:create}, :message => \"${5:must be present}\"}, :if => proc { |obj| ${6:obj.condition?} }}"},
 "vnif" => 
  {scope: "source.ruby.rails",
   name: "validates_numericality_of if",
   content: 
    "validates_numericality_of :${1:attribute}${2:, :on => :${3:create}, :message => \"${4:is not a number}\"}, :if => proc { |obj| ${5:obj.condition?} }}"},
 "vn" => 
  {scope: "source.ruby.rails",
   name: "validates_numericality_of",
   content: 
    "validates_numericality_of :${1:attribute}${2:, :on => :${3:create}, :message => \"${4:is not a number}\"}"},
 "wants" => 
  {scope: "meta.rails.controller",
   name: "wants.format",
   content: "wants.${1:js|xml|html}${2: { $0 \\}}"},
 "xdelete" => 
  {scope: "source.ruby.rails",
   name: "xhr delete",
   content: "xhr :delete, :${1:destroy}, :id => ${2:1}$0"},
 "xget" => 
  {scope: "source.ruby.rails",
   name: "xhr get",
   content: "xhr :get, :${1:show}${2:, :id => ${3:1}}$0"},
 "xpost" => 
  {scope: "source.ruby.rails",
   name: "xhr post",
   content: "xhr :post, :${1:create}, :${2:object} => { $3 }"},
 "xput" => 
  {scope: "source.ruby.rails",
   name: "xhr put",
   content: "xhr :put, :${1:update}, :id => ${2:1}, :${3:object} => { $4 }$0"}}
