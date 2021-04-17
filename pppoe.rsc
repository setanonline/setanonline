#PPPOE AUTOISOLIR BY SETAN ONLINE
#script by Mz PAY

/ppp profile
set [find] on-up="{\
    \n:put (\",rem,4000,2d,4000,,Enable,\"); \
    \n{\
    \n:local date [ /system clock get date ];\
    \n:local year [ :pick \$date 7 11 ];\
    \n:local month [ :pick \$date 0 3 ];\
    \n:local comment [ /ppp sec get [/ppp sec find where name=\"\$user\"] comm\
    ent]; \
    \n:local ucode [:pic \$comment 0 2]; \
    \n:if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={\
    \n/sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"30d\
    \"; \
    \n:delay 2s; \
    \n:local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-r\
    un]; \
    \n:local getxp [len \$exp]; \
    \n:if (\$getxp = 15) do={\
    \n:local d [:pic \$exp 0 6]; \
    \n:local t [:pic \$exp 7 16]; \
    \n:local s (\"/\"); \
    \n:local exp (\"\$d\$s\$year\"); \
    \n/ppp sec set comment=\$exp [find where name=\"\$user\"];\
    \n}; \
    \n:if (\$getxp = 8) do={\
    \n/ppp sec set comment=\"\$date \$exp\" [find where name=\"\$user\"];\
    \n}; \
    \n:if (\$getxp > 15) do={\
    \n/ppp sec set comment=\$exp [find where name=\"\$user\"];\
    \n}; \
    \n/sys sch remove [find where name=\"\$user\"]; \
    \n:if ([/sys scr print count where name=\"tg_config\"]>0) do={\
    \n:local hasil\
    \n:set hasil \" =======PPPOE====== %0A\\\
    \n>>> \$user <<< %0A\\\
    \nAktif: \$exp %0A\\\
    \n====================\"\
    \n:local send [:parse [/system script get tg_sendMessage source]]\
    \n\$send chat=\$chatid text=\$hasil mode=\"Markdown\"\
    \n:return true\
    \n\
    \n}\
    \n}\
    \n}\
    \n}"
    
    
/system scheduler
add interval=1m name="AUTO ISOLIR" on-event="\r\
    \n#AUTO ISOLIR\r\
    \n\r\
    \n:local exp [sys clock get date]\r\
    \n:local jumlah [ppp sec print count where comment=\"\$exp\"]\r\
    \n:if (\$jumlah > 0) do={\r\
    \n[/ppp sec set [find where comment=\"\$exp\"] comment=\"TERISOLIR\" disab\
    led=yes]\r\
    \n}\r\
    \n\r\
    \n#JEDA\r\
    \n\r\
    \n:delay 2s\r\
    \n\r\
    \n#CEK TELEGRAM\r\
    \n\r\
    \n:local tele\r\
    \n:if (\$jumlah > 0) do={\r\
    \n:if ([/sys scr print count where name=\"tg_config\"]>0) do={:set tele \"\
    1\"}\r\
    \n}\r\
    \n\r\
    \n#SET PESAN\r\
    \n\r\
    \n:local isolir\r\
    \n:local frame \"======================== %0A\"\r\
    \n:local text0 (\"*\".[sys iden get name].\"*\".\"%0A\")\r\
    \n:local text1 \"==========PPPOE======== %0A\"\r\
    \n:local text2 \"%0A\\\r\
    \n=======TERISOLIR =======\"\r\
    \n:if (\$tele = 1) do={\r\
    \n:foreach i in=[ppp sec find where comment=\"TERISOLIR\"] do={\r\
    \n:local nama (\"=> \" . [/ppp sec get \$i name] . \"%0A\")\r\
    \n:set isolir (\$isolir . \$nama)\r\
    \n}\r\
    \n}\r\
    \n\r\
    \n##KIRIM KE TELEGRAM\r\
    \n\r\
    \n:if (\$tele = 1 ) do={\r\
    \n:local send [:parse [/system script get tg_sendMessage source]]\r\
    \n:put \$params\r\
    \n:put \$chatid\r\
    \n:put \$from\r\
    \n\$send chat=\$chatid text=(\"\$frame\$text0\$frame\$text1%0A\$isolir\$te\
    xt2\") mode=\"Markdown\"\r\
    \n:return true\r\
    \n}\r\
    \n\r\
    \n" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
:delay 5s
/file remove [find name="pppoe.rsc"]


