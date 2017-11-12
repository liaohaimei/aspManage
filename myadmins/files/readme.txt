配置文件config.asp

Const Root = "upload/%2_23"	'管理根目录，兼容已盘符开头的物理路径
Const AllowExt = "*.bmp;*.rar;*.jpg;*.gif;*.png;*.doc;*.zip;"	'允许上传的文件类型，全部请使用*.*	
Const AllowFileSizeLimit = "500kb" '允许上传的文件大小，支持“数字+单位”或纯数字，例如1kb=1024