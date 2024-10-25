const Report = require('../models/reportModel');

const getEmployeesReport = async (req, res) => {
    const filterBy = req.query?.filterBy;
    const filterValue = req.query?.filterValue;

    if(!filterBy || !filterValue) {
        return res.status(400).json({message: 'Query parameters filterBy and filterValue are required'});
    }

    let result;

    try{
        switch(filterBy.toLowerCase()) {
            case 'department':
                result = await Report.getEmployeesByDepartment(filterValue);
                break;
            case 'branch':
                result = await Report.getEmployeesByBranch(filterValue);
                break;
            case 'job title':
                result = await Report.getEmployeesByJobTitle(filterValue);
                break;
            case 'pay grade':
                result = await Report.getEmployeesByPayGrade(filterValue);
                break;
            case 'employment status':
                result = await Report.getEmployeesByEmploymentStatus(filterValue);
                break;
            default:
                return res.status(400).json({message: 'Invalid query parameter'});
        }

        res.json(result);
    } catch (error) {
        console.error(error);
        res.status(500).json({message: 'Internal server error'});
    }
}


const getLeaveCountReport = async (req, res) => {
    const filterBy = req.query?.filterBy;
    const fromDate = req.query?.fromDate;
    const toDate = req.query?.toDate;

    if(!filterBy || !fromDate || !toDate) {
        return res.status(400).json({message: 'Query parameters filterBy, filterValue, fromDate and toDate are required'});
    }

    let result;

    try{
        switch(filterBy.toLowerCase()) {
            case 'department':
                result = await Report.getLeaveCountByDepartment(fromDate, toDate);
                break;
            case 'branch':
                result = await Report.getLeaveCountByBranch(fromDate, toDate);
                break;
            case 'job title':
                result = await Report.getLeaveCountByJobTitle(fromDate, toDate);
                break;
            case 'pay grade':
                result = await Report.getLeaveCountByPayGrade(fromDate, toDate);
                break;
            case 'employment status':
                result = await Report.getLeaveCountByEmploymentStatus(fromDate, toDate);
                break;
            default:
                return res.status(400).json({message: 'Invalid query parameter'});
        }
        
        res.json(result);
    } catch (error) {
        console.error(error);
        res.status(500).json({message: 'Internal server error'});
    }
}

const getFilterByValues = async (req, res) => {
    try{
        const departments = await Report.getDepartments();
        const branches = await Report.getBranches();
        const jobTitles = await Report.getJobTitles();
        const payGrades = await Report.getPayGrades();
        const employmentStatuses = await Report.getEmploymentStatuses();

        let departmentNames = departments.map(department => department.department_name);
        let branchNames = branches.map(branch => branch.branch_name);
        let jobTitleNames = jobTitles.map(jobTitle => jobTitle.job_title);
        let payGradeNames = payGrades.map(payGrade => payGrade.pay_grade);


        res.json({
            departments: departmentNames,
            branches: branchNames,
            jobTitles: jobTitleNames,
            payGrades: payGradeNames,
            employmentStatuses
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({message: 'Internal server error'});
    }
}

module.exports = {
    getEmployeesReport,
    getLeaveCountReport,
    getFilterByValues
}