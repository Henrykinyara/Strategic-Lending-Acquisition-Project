use HenryKinyaraDatabase;

Select*From Disbursements;
Select*From Repayments;

Select* from Disbursements left join Repayments
on Disbursements.customer_id=Repayments.customer_id;

--Total Loan Amount disbursed to each customer
Select customer_id, SUM(loan_amount) as Total_Loan_Amount_Disbursed
Into Total_Loan_Disbursements
from Disbursements
Group by customer_id;

--Total Loan repayment by each customer
Select customer_id, SUM(amount) as Total_Loan_Amount_Repayed
Into Total_Loan_Repayments
from Repayments
Group by customer_id;

Select*From Total_Loan_Disbursements;
Select*From Total_Loan_Repayments;

--Customer Repayment vs Disbursement
Select Total_Loan_Disbursements.customer_id,Total_Loan_Amount_Disbursed,Total_Loan_Amount_Repayed
into Customer_Repayment_vs_Disbursement
From Total_Loan_Disbursements Full Join Total_Loan_Repayments
on Total_Loan_Disbursements.customer_id=Total_Loan_Repayments.customer_id;

Select*From Customer_Repayment_vs_Disbursement;

--Total Amount Disbursed & Total Amount Repayed
Select Format(Sum(Total_Loan_Amount_Disbursed),'N0') as Total_Loan_Amount_Disbursed from  Customer_Repayment_vs_Disbursement;
Select Format(Sum(Total_Loan_Amount_Repayed),'N0') as Total_Loan_Amount_Repayed from  Customer_Repayment_vs_Disbursement
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Select*From Disbursements;
Select*From Repayments;


--Repayment Type

Select Count(*) as Total_Manual_Payments_Made, Format(Sum(amount), 'N0') as Total_Amount From Repayments
where repayment_type='Manual';
Select Count(*) as Total_Automatic_Payments_Made, Format(Sum(amount), 'N0') as Total_Amount From Repayments
where repayment_type='Automatic';

--Creating table and view for PowerBI 

Select Disbursements.customer_id,Disbursements.disb_date,Disbursements.tenure,Disbursements.loan_amount,Disbursements.loan_fee,
Repayments.date_time,Repayments.amount,Repayments.repayment_type
into Loan_Disbursement_and_Repayment
from Disbursements Full join Repayments
on Disbursements.customer_id=Repayments.customer_id
Order by disb_date ;

Select*From Loan_Disbursement_and_Repayment;

Go
Create view VW_Loan_Disbursement_and_Repayment
As Select*From Loan_Disbursement_and_Repayment
Go;

--Individual customer info

Select Loan_Disbursement_and_Repayment.customer_id,Loan_Disbursement_and_Repayment.disb_date ,sum((Loan_Disbursement_and_Repayment.loan_amount+Loan_Disbursement_and_Repayment.loan_fee)) As Total_Loan
From Loan_Disbursement_and_Repayment
Group by Loan_Disbursement_and_Repayment.customer_id,Loan_Disbursement_and_Repayment.disb_date









