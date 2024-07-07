use lifemakers;
# 1-للاستعلام عن اسم الحملة وما يخص هذه الحملة من الناتج المادي (تحت اسم "ناتج الحملة")
select r.campaign_name, sum(m.amount) as 'total money'
from raise r ,money m where  r.donations_id=m.donations_id 
group by  r.campaign_name;

# 2-الاستعلام عن اسماء المتطوعين و الحملات اللي شاركوا فيها
select p.name,v.campaign_name 
from person p,volunteer v 
where p.ssn=v.person_ssn;

# 3-الاستعلام عن كل المعلومات عن الفقراء
select p.*,n.*from person p , needypeople n where p.ssn=n.person_ssn; 

# 4-الاستعلام عن المكان الاداري وعنوانه واسم مديره( تحت اسم "اسم المدير")
select a.locality_name,l.l_location,p.name as'manager name' from adminstrator a, locality_location l,person p 
where a.locality_name=l.l_name and p.ssn= a.person_ssn;

# 5-استعلام عن اسماء الملفات و المتطوعين التي تعمل بها و وصف الملفات
select v.folders_fname, p.name , f.description from volunteer v, person p , folders f
where p.ssn=v.person_ssn and v.folders_fname= f.name group by p.name order by 1 desc ;

# 6-استعلام عن الحملات و عدد المتطوعين المشاركين فيها واسم مدير الحملة
select c.* , p.name as'manager',count(v.campaign_name) as 'number of participants'
from campaign c,person p,volunteer v 
where c.name=v.campaign_name and p.ssn=c.mang_ssn
group by c.name ; 

# 7-استعلام عن مجلس الامناء
select p.*,b.type from person p,board_of_trusts b where p.ssn=b.person_ssn;

# 8-الاستعلام عن اسماء ومرتبات المديرين وترتيبهم
SELECT p.name, a.salary 
FROM person p,adminstrator a
WHERE p.ssn = a.person_ssn
ORDER BY 2 DESC;

# 9-الاستعلام عن انواع التبرعات الماديه ومجموعها
select d.class ,sum(m.amount) as 'total' from donations d,money m where d.id=m.donations_id
group by d.class;

# 10-الاستعلام عن ترتيب المتطوعين من حيث تجميع التبرعات وعن اسم المقر التابعين له
select p.name,a.v_ssn,v.locality_name,m.amount from person p,volunteer v,money m,accept a
where p.ssn=v.person_ssn and a.donations_id=m.donations_id and a.v_ssn=v.person_ssn
group by p.name
order by 4 desc;

# 11-استعلام عن الفقراء الذي في عنوانهم مدينة منوف
select n.* from needypeople n where n.address like  '% menouf %';

# 12-الاستعلام عن اكبر مبلغ تم التبرع به
select max(amount) as 'max donatin' from money;

# 13- الاستعلام عن انواع التبرعات 
select class as 'type of donations' from donations;

# 14-(one table)اسماء الاشخاص المحتاجين الى عمل
SELECT  n.person_ssn FROM needypeople n
WHERE state in( SELECT state FROM needypeople WHERE state ='work' );

# 15- الاستعلام عن عدد المتطوعين الاناث
select p.gender , count(distinct v.person_ssn) as 'number of female' from volunteer v ,person p 
where p.ssn=v.person_ssn
group by gender having gender='f' ;

# 16-الاستعلام عن تواريخ التبرعات 
select date,donations_id from accept ;

# 17-الاستعلام عن ترتيب المدن من حيث عدد المتطوعين
select locality_name as 'city',count(person_ssn)as 'number of volunteers' from volunteer
group by locality_name  order by 2 desc;