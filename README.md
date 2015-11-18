# pdf-generator

## Stack
- Backend - rails-api, devise_token_auth, wicked_pdf, whenever, rspec-rails
- Front-end - yeoman, angularJS, bootstrap

wkhtmltopdf 0.12.2.1 

[Example of a pdf report!](https://github.com/yahorzhylinski/pdf-generator/blob/master/example-report.pdf)
At the first page is campaign and its creatives overviews. And next 3 pages are graphics.

How to run front-end https://github.com/yeoman/generator-angular

Reports you can create using a rake command:
```
rake reports:create
```

## Algorithm
A User makes a request for a report. Cron every 5 minutes generates reports for all pending users.
I implemented this logic because i think that it's too reach operation to make a report for each user request.

Also i think it's a good idea to implement WebSockets.

## Platform161Api
In lib folder i implemented Platform161Api namespace which includes classes for Platform161 Api.

Implemented modules Statisticable and Crudable. Crudable implements static functions: :find and :all

To get a Campaign by id you can write
```
Platform161Api::Models::Campaign.find id
```
To get alll creatives by campaign_id:
```
Platform161Api::Models::Creative.find_all_by_campaign_id campaign_id
```
Statisticable calculates all dynamic values(ecpa, ecpc, ...) for a report. Models: Platform161Api::Models::Creative, Platform161Api::Models::Day, Platform161Api::Models::Campaign include this module


## Problems
Advertiser Report request isn't good documentated. Maybe reports which i generate are not correct.
AdvertiserReport API request doesn't work with a period different to :last_30_days.
I get info only about campaign #2140779 from v2/advertiser_reports.

## Screenshots
![alt tag](https://github.com/yahorzhylinski/pdf-generator/blob/master/screenshots/Screenshot%20from%202015-11-12%2021:48:20.png)
![alt tag](https://github.com/yahorzhylinski/pdf-generator/blob/master/screenshots/Screenshot%20from%202015-11-12%2021:48:45.png)
![alt tag](https://github.com/yahorzhylinski/pdf-generator/blob/master/screenshots/Screenshot%20from%202015-11-12%2021:49:06.png)
![alt tag](https://github.com/yahorzhylinski/pdf-generator/blob/master/screenshots/Screenshot%20from%202015-11-12%2021:49:45.png)
![alt tag](https://github.com/yahorzhylinski/pdf-generator/blob/master/screenshots/Screenshot%20from%202015-11-12%2021:49:29.png)
