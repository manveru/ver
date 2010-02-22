# Encoding: UTF-8

{"url" => 
  {scope: "source.python.django",
   name: "URLField",
   content: 
    "${1:FIELDNAME} = models.URLField(${2:blank=True}, verify_exists=${3:True})"},
 "usstate" => 
  {scope: "source.python.django",
   name: "USStateField",
   content: "${1:FIELDNAME} = models.USStateField(${2:blank=True})"},
 "smallinteger" => 
  {scope: "source.python.django",
   name: "SmallIntegerField",
   content: 
    "${1:FIELDNAME} = models.SmallIntegerField(${2:blank=True, null=True})"},
 "positiveinteger" => 
  {scope: "source.python.django",
   name: "PositiveIntegerField",
   content: 
    "${1:FIELDNAME} = models.PositiveIntegerField(${2:blank=True, null=True})"},
 "datetime" => 
  {scope: "source.python.django",
   name: "DateTimeField",
   content: 
    "${1:FIELDNAME} = models.DateTimeField(${2:blank=True}${3:, default=datetime.datetime.now})"},
 "nullboolean" => 
  {scope: "source.python.django",
   name: "NullBooleanField",
   content: "${1:FIELDNAME} = models.NullBooleanField(${2:default=True})"},
 "positivesmallinteger" => 
  {scope: "source.python.django",
   name: "PositiveSmallIntegerField",
   content: 
    "${1:FIELDNAME} = models.PositiveSmallIntegerField(${2:blank=True, null=True})"},
 "filepath" => 
  {scope: "source.python.django",
   name: "FilePathField",
   content: 
    "${1:FIELDNAME} = models.FilePathField(path=\"${1:/location/of/choices}\"${2:, match=\"${3:regex}\"}${4:, recursive=True})"},
 "float" => 
  {scope: "source.python.django",
   name: "FloatField",
   content: "${1:FIELDNAME} = models.FloatField()"},
 "auto" => 
  {scope: "source.python.django",
   name: "AutoField",
   content: "${1:FIELDNAME} = models.AutoField()"},
 "email" => 
  {scope: "source.python.django",
   name: "EmailField",
   content: "${1:FIELDNAME} = models.EmailField()"},
 "manytomany" => 
  {scope: "source.python.django",
   name: "ManyToManyField",
   content: "${1:FIELDNAME} = models.ManyToManyField(${2:RELATED_MODEL})"},
 "boolean" => 
  {scope: "source.python.django",
   name: "BooleanField",
   content: "${1:FIELDNAME} = models.BooleanField(${2:default=True})"},
 "file" => 
  {scope: "source.python.django",
   name: "FileField",
   content: 
    "${1:FIELDNAME} = models.FileField(upload_to=${1:/path/for/upload})"},
 "model" => 
  {scope: "source.python.django",
   name: "Model Skeleton",
   content: 
    "class ${1:Modelname}(models.Model):\n\t\"\"\"${2:($1 description)}\"\"\"\n\t$0\n\n\tclass Admin:\n\t\tlist_display = ('',)\n\t\tsearch_fields = ('',)\n\n\tdef __unicode__(self):\n\t\treturn u\"$1\"\n"},
 "text" => 
  {scope: "source.python.django",
   name: "TextField",
   content: "${1:FIELDNAME} = models.TextField(${2:blank=True})"},
 "xml" => 
  {scope: "source.python.django",
   name: "XMLField",
   content: 
    "${1:FIELDNAME} = models.XMLField(schema_path=${2:/path/to/RelaxNG}${3:, blank=True})"},
 "time" => 
  {scope: "source.python.django",
   name: "TimeField",
   content: "${1:FIELDNAME} = models.TimeField(${2:blank=True})"},
 "slug" => 
  {scope: "source.python.django",
   name: "SlugField",
   content: "${1:slug} = models.SlugField(${2:prepopulate_from=(\"$3\",$4)})"},
 "commaseparatedinteger" => 
  {scope: "source.python.django",
   name: "CommaSeparatedIntegerField",
   content: 
    "${1:FIELDNAME} = models.CommaSeparatedIntegerField(max_length=$2)"},
 "integer" => 
  {scope: "source.python.django",
   name: "IntegerField",
   content: 
    "${1:FIELDNAME} = models.IntegerField(${2:blank=True, null=True})"},
 "ipaddress" => 
  {scope: "source.python.django",
   name: "IPAddressField",
   content: "${1:FIELDNAME} = models.IPAddressField(${2:blank=True})"},
 "decimal" => 
  {scope: "source.python.django",
   name: "DecimalField",
   content: 
    "${1:FIELDNAME} = models.DecimalField(max_digits=$2, decimal_places=$3)"},
 "sendmail" => 
  {scope: "source.python.django",
   name: "send_mail",
   content: 
    "mail.send_mail(\"${1:Subject}\", \"${2:Message}\", \"${3:from@example.com}\", ${4:[\"to@example.com\"]}${5:, fail_silently=True})\n"},
 "fk" => 
  {scope: "source.python.django",
   name: "ForeignKey",
   content: "${1:FIELDNAME} = models.ForeignKey(${2:RELATED_MODEL})"},
 "image" => 
  {scope: "source.python.django",
   name: "ImageField",
   content: 
    "${1:FIELDNAME} = models.ImageField(upload_to=\"${2:/dir/path}\"${3:, height_field=$4}${5:, width_field=$6})"},
 "char" => 
  {scope: "source.python.django",
   name: "CharField",
   content: 
    "${1:FIELDNAME} = models.CharField(${2:blank=True}, max_length=${3:100})"},
 "date" => 
  {scope: "source.python.django",
   name: "DateField",
   content: 
    "${1:FIELDNAME} = models.DateField(${2:default=datetime.datetime.today})"},
 "phonenumber" => 
  {scope: "source.python.django",
   name: "PhoneNumberField",
   content: "${1:FIELDNAME} = models.PhoneNumberField(${2:blank=True})"}}
