Login page with notifications system using NodeJS for Examly

## Database Type ##
* Since we are storing structured data i went with MySQL.
* Since we would display only a particular number of notifications when the user clicks the notificatoin bell, going with MySQL seemed better.
* Considering the requirements visualizing database as tables makes more sense than visualizing the data as a bunch of documents.

## Database Schema ##
![](image/schema.png)
* Entity will help us to know what the notification is about. For example, a notification can be about a creation of a course, course completion of a student etc. To get the details of any entity, all we need is to know entity table’s primary key value. This value will be referred as entityId.
* Entity types are the different types of notifications. To identify each entity, we will give an ID to each and every entity type.
* Read and Clicked maintains the asked metadata.

## API ##



## Performance Metrics ##
