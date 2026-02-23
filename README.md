# PracticumPrepProject
# מערכת לניהול נכסי נדל"ן - ארה"ב

## נושא הפרויקט
[cite_start]מערכת לניהול וחיפוש דירות למכירה ולהשכרה ברחבי ארצות הברית. [cite: 167]

## מבנה מסד הנתונים (SQL Server)
[cite_start]המערכת מבוססת על 3 טבלאות עם קשרים ביניהן: [cite: 55, 168]
1. [cite_start]**Apartments** (טבלה ראשית): שומרת את פרטי הדירות כמו כותרת, תיאור ומחיר. [cite: 56, 58]
2. [cite_start]**Cities** (טבלת עזר): רשימת ערים בארה"ב. [cite: 65]
3. [cite_start]**Statuses** (טבלת עזר): ניהול מצב הדירה (למכירה, להשכרה, נמכר). [cite: 65]

## פרוצדורות (Stored Procedures)
[cite_start]כל הגישה לנתונים מתבצעת אך ורק דרך הפרוצדורות הבאות: [cite: 71, 159, 169]
* [cite_start]`GetAllApartments`: שליפת כל רשימת הדירות כולל אפשרות לחיפוש טקסט חופשי. [cite: 79]
* [cite_start]`GetApartmentById`: שליפת פרטים מלאים על דירה ספציפית לפי מזהה. [cite: 76]
* [cite_start]`CreateApartment`: הוספת דירה חדשה למערכת. [cite: 73]
* [cite_start]`UpdateApartment`: עדכון נתונים של דירה קיימת. [cite: 75]
* [cite_start]`DeleteApartment`: מחיקת רשומה מהמערכת. [cite: 84]

## טכנולוגיות בפרויקט
* [cite_start]**Frontend:** Angular [cite: 6]
* [cite_start]**Backend:** .NET Web API [cite: 7]
* [cite_start]**Database:** SQL Server (Stored Procedures) [cite: 8, 23]
