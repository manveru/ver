# Encoding: UTF-8

{fileTypes: ["rb", "rxml", "builder"],
 foldingStartMarker: 
  /(?x)^
	    (?<_1>\s*+
	        (?<_2>module|class|def
	        |unless|if
	        |case
	        |begin
	        |for|while|until
	        |(?<_3>  "(?<_4>\\.|[^"])*+"          # eat a double quoted string
	         | '(?<_5>\\.|[^'])*+'        # eat a single quoted string
	         |   [^#"']                # eat all but comments and strings
	         )*
	         (?<_6>                 \s   (?<_7>do|begin|case)
	         | [-+=&|*\/~%^<>~] \s*+ (?<_8>if|unless)
	         )
	        )\b
	        (?! [^;]*+ ; .*? \bend\b )
	    |(?<_9>  "(?<_10>\\.|[^"])*+"              # eat a double quoted string
	     | '(?<_11>\\.|[^'])*+'            # eat a single quoted string
	     |   [^#"']                    # eat all but comments and strings
	     )*
	     (?<_12> \{ (?!  [^}]*+ \} )
	     | \[ (?! [^\]]*+ \] )
	     )
	    ).*$
	|   [#] .*? \(fold\) \s*+ $         # Sune’s special marker
	/,
 foldingStopMarker: 
  /(?x)
	(?<_1>   (?<_2>^|;) \s*+ end   \s*+ (?<_3>[#].*)? $
	|   ^     \s*+ [}\]] \s*+ (?<_4>[#].*)? $
	|   [#] .*? \(end\) \s*+ $    # Sune’s special marker
	)/,
 keyEquivalent: "^~R",
 name: "Ruby on Rails",
 patterns: 
  [{begin: 
     /(?<_1>^\s*)(?=class\s+(?<_2>(?<_3>[.a-zA-Z0-9_:]+ControllerTest(?<_4>\s*<\s*[.a-zA-Z0-9_:]+)?)))/,
    comment: 
     "Uses lookahead to match classes with the ControllerTest suffix; includes 'source.ruby' to avoid infinite recursion",
    end: "^\\1(?=end)\\b",
    name: "meta.rails.functional_test",
    patterns: [{include: "source.ruby"}, {include: "$self"}]},
   {begin: 
     /(?<_1>^\s*)(?=class\s+(?<_2>(?<_3>[.a-zA-Z0-9_:]+Controller\b(?<_4>\s*<\s*[.a-zA-Z0-9_:]+)?)|(?<_5><<\s*[.a-zA-Z0-9_:]+)))(?!.+\bend\b)/,
    comment: 
     "Uses lookahead to match classes with the Controller suffix; includes 'source.ruby' to avoid infinite recursion",
    end: "^\\1(?=end)\\b",
    name: "meta.rails.controller",
    patterns: [{include: "source.ruby"}, {include: "$self"}]},
   {begin: 
     /(?<_1>^\s*)(?=module\s+(?<_2>(?<_3>(?<_4>[A-Z]\w*::)*)[A-Z]\w*)Helper)/,
    comment: 
     "Uses lookahead to match modules with the Helper suffix; includes 'source.ruby' to avoid infinite recursion",
    end: "^\\1(?=end)\\b",
    name: "meta.rails.helper",
    patterns: [{include: "source.ruby"}, {include: "$self"}]},
   {begin: 
     /(?<_1>^\s*)(?=class\s+(?<_2>(?<_3>[.a-zA-Z0-9_:]+(?<_4>\s*<\s*ActionMailer::Base))))/,
    comment: 
     "Uses lookahead to match classes that inherit from ActionMailer::Base; includes 'source.ruby' to avoid infinite recursion",
    end: "^\\1(?=end)\\b",
    name: "meta.rails.mailer",
    patterns: [{include: "source.ruby"}, {include: "$self"}]},
   {begin: /(?<_1>^\s*)(?=class\s+.+ActiveRecord::Base)/,
    comment: 
     "Uses lookahead to match classes that (may) inherit from ActiveRecord::Base; includes 'source.ruby' to avoid infinite recursion",
    end: "^\\1(?=end)\\b",
    name: "meta.rails.model",
    patterns: [{include: "source.ruby"}, {include: "$self"}]},
   {begin: /(?<_1>^\s*)(?=class\s+.+ActiveRecord::Migration)/,
    comment: 
     "Uses lookahead to match classes that (may) inherit from ActiveRecord::Migration; includes 'source.ruby' to avoid infinite recursion",
    end: "^\\1(?=end)\\b",
    name: "meta.rails.migration",
    patterns: 
     [{begin: /(?<_1>^\s*)(?=change_table)\b/,
       comment: 
        "Uses lookahead to match methods change_table; includes 'source.ruby' to avoid infinite recursion",
       contentName: "meta.rails.migration.change_table",
       end: "^\\1(?=end)\\b",
       patterns: [{include: "source.ruby"}, {include: "$self"}]},
      {begin: /(?<_1>^\s*)(?=create_table)\b/,
       comment: 
        "Uses lookahead to match methods create_table; includes 'source.ruby' to avoid infinite recursion",
       contentName: "meta.rails.migration.create_table",
       end: "^\\1(?=end)\\b",
       patterns: [{include: "source.ruby"}, {include: "$self"}]},
      {include: "source.ruby"},
      {include: "$self"}]},
   {begin: 
     /(?<_1>^\s*)(?=class\s+(?![.a-zA-Z0-9_:]+ControllerTest)(?<_2>(?<_3>[.a-zA-Z0-9_:]+Test(?<_4>\s*<\s*[.a-zA-Z0-9_:]+)?)|(?<_5><<\s*[.a-zA-Z0-9_:]+)))/,
    comment: 
     "Uses lookahead to match classes with the Test suffix; includes 'source.ruby' to avoid infinite recursion",
    end: "^\\1(?=end)\\b",
    name: "meta.rails.unit_test",
    patterns: [{include: "source.ruby"}, {include: "$self"}]},
   {begin: /(?<_1>^\s*)ActionController::Routing::Routes/,
    comment: 
     "Uses ActionController::Routing::Routes to determine it is a routes file; includes 'source.ruby' to avoid infinite recursion",
    end: "^\\1(?=end)\\b",
    name: "meta.rails.routes",
    patterns: [{include: "source.ruby"}, {include: "$self"}]},
   {match: 
     /\b(?<_1>before_filter|skip_before_filter|skip_after_filter|after_filter|around_filter|filter|filter_parameter_logging|layout|require_dependency|render|render_action|render_text|render_file|render_template|render_nothing|render_component|render_without_layout|rescue_from|url_for|redirect_to|redirect_to_path|redirect_to_url|respond_to|helper|helper_method|model|service|observer|serialize|scaffold|verify|hide_action)\b/,
    name: "support.function.actionpack.rails"},
   {match: 
     /\b(?<_1>named_scope|after_create|after_destroy|after_save|after_update|after_validation|after_validation_on_create|after_validation_on_update|before_create|before_destroy|before_save|before_update|before_validation|before_validation_on_create|before_validation_on_update|composed_of|belongs_to|has_one|has_many|has_and_belongs_to_many|validate|validate_on_create|validates_numericality_of|validate_on_update|validates_acceptance_of|validates_associated|validates_confirmation_of|validates_each|validates_format_of|validates_inclusion_of|validates_exclusion_of|validates_length_of|validates_presence_of|validates_size_of|validates_uniqueness_of|attr_protected|attr_accessible|attr_readonly)\b/,
    name: "support.function.activerecord.rails"},
   {match: 
     /\b(?<_1>alias_method_chain|alias_attribute|delegate|cattr_accessor|mattr_accessor|returning)\b/,
    name: "support.function.activesupport.rails"},
   {include: "source.ruby"}],
 scopeName: "source.ruby.rails",
 uuid: "54D6E91E-8F31-11D9-90C5-0011242E4184"}
