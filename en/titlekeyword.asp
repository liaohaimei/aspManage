
<%
dim pageTitle,pageKeyword,pageContent
'页面标题
if pid<>"" then
if ArticleTitle(pid)<>"" then
t_type=1
end if
end if

if id<>"" then
if ContentPageTitle(id)<>"" then
t_type=2
end if
end if

if ids<>"" and id="" then
if ContentPageTitle(ids)<>"" then
t_type=3
end if
end if

'页面关键字
if pid<>"" then
if ArticleKeyword(pid)<>"" then
k_type=1
end if
end if

if id<>"" then
if ContentKeywords(id)<>"" then
k_type=2
end if
end if

if ids<>"" and id="" then
if ContentKeywords(ids)<>"" then
k_type=3
end if
end if

'页面描述

if pid<>"" then
if ArticleDescriptions(pid)<>"" then
c_type=1
end if
end if

if id<>"" then
if ContentDescriptions(id)<>"" then
c_type=2
end if
end if

if ids<>"" and id="" then
if ContentDescriptions(ids)<>"" then
c_type=3
end if
end if

select case t_type
case 1
pageTitle=ArticleTitle(pid)
case 2
pageTitle=ContentPageTitle(id)
case 3
pageTitle=ContentPageTitle(ids)
case else
pageTitle=ConfigurationTitle(1)
end select

select case k_type
case 1
pageKeyword=ArticleKeyword(pid)
case 2
pageKeyword=ContentKeywords(id)
case 3
pageKeyword=ContentKeywords(ids)
case else
pageKeyword=ConfigurationKeyword(1)
end select

select case c_type
case 1
pageContent=ArticleDescriptions(pid)
case 2
pageContent=ContentDescriptions(id)
case 3
pageContent=ContentDescriptions(ids)
case else
pageContent=ConfigurationDescriptions(1)
end select

%>
