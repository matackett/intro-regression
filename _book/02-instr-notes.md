# Notes for Instructors {#instr}

This chapter includes details for setting up RStudio Cloud and GitHub in your course. The information in this chapter is based on the [Infrastructure](https://datasciencebox.org/infrastructure/) page in [@dsbox] and experience from previous courses. 

## Setting up your course

### GitHub

GitHub can be used as a course management platform that is  a more flexible alternative traditional platforms such as Blackboard and Sakai [@cr2018]. It can be used as the central place to share course content and for students to submit assignments. It is structured to promote collaboration, so it is good for courses that include a lot of group assignments. It also gives students practice establishing a workflow that is  more representative of what is currently being used in industry.

Before setting up your course, create an account on [GitHub.com](https://github.com/) if you do not already have one. The chapter [Register a GitHub account](https://happygitwithr.com/github-acct.html) in [@happygit] has helpful guidelines to consider when making a GitHub username. 

To set up your course organization in GitHub:  

1. [Create a new organization](https://help.github.com/en/enterprise/2.16/admin/user-management/creating-organizations) in GitHub. To keep things simple, you can name the organization based on the course number and semester. For example, the organization name for my most recent Regression Analysis course was STA210-Sp19.

2.  Apply for the [GitHub Education benefits](https://education.github.com/discount_requests/new) to obtain free private repositories for your course organization. By default any repositories created in the course organization will be private and only visible and accessible  to the student (or group of students) whose assignment it is and the instructor. This is to comply with Family Educational Rights and Privacy Act (FERPA). 

3. Have students create a GitHub username and send it to you. You can share the guidelines from [@happygit] to help students create usernames that are applicable beyond their time in your course that can be shared with future employers.

    I typically have students provide their GitHub username as part of the "Getting to Know You" survey at the beginning of the semester. It doesn't take long to create a GitHub username, so this could also be done as an activity on one of the first few days of class. 

4. Add students to the GitHub course organization using the `ghclass` R package. The section ["Adding students and creating teams"](https://rundel.github.io/ghclass/articles/ghclass.html) in [@ghclass] provides step-by-step instructions for adding new members to the course organization. 

5. If students will be working in teams, you can add the teams to the GitHub course organization using by following the steps in [@ghclass]. Any assignment repo for a group assignment will be visible and accessbile to all the members of the team and instructor. 

6. You're done! Now you're ready to create your first assignment, which is described in the sections below. 

### RStudio Cloud

There are a few key benefits of using RStudio Cloud rather than having students install RStudio on their local machines: 

- Students can get started working in RStudio immediately, since there is no need for students to install RStudio or configure it with Git. 
- You can ensure students have the packages (and correct versions!) needed to complete assignments by installing them in the course workspace's base project. 
- Students can copy any projects you share with everyone in the workspace, which makes in-class activities more feasible. 
- As an instructor, you can view all student projects making it easier to help students remotely when coding issues occur. 

To set up the workspace for your course: 

1. Go to [rstudio.cloud](https://rstudio.cloud/) and log in or create a new acount. I used the option to log in using my GitHub credentials to keep things simple. 

2. Click to create a "New Space" and follow the prompts to create a private workspace for your course.

3. By default, the workspace only holds 10 members and 25 projects. If you need more space for course, submit a request by emailing <a href = "mailto: support@rstudio.com">support@rstudio.com</a>.

3. In the course workspace, go to the "Members" menu and click options. Change the access to "Shared" to create a sharing link that can be distributed to your students. Anyone who clicks the link will automatically be added to your course workspace.  Students can log in to RStudio Cloud using their Github credentials. 

    After the first few weeks of class, you can change the access to the course space to "Invitation     required". At that point you would need to send an invitation to anyone else wanting to join the course workspace.
    
    See the [RStudio Cloud guide](https://rstudio.cloud/learn/guide#space-members) for more details about adding members and specific member roles. Some suggested roles are
    - Primary instructor: Admin role that can manage membership, view, edit and manage all projects in the workspace
    - Secondary instructors / Teaching assistants: Moderator role that can view, edit and manage all projects in the workspace 
    - Students: Contributor role (default) that can create, edit and manage their own projects.

<br>

4. You're done! Now you're ready to create your first project in RStudio Cloud.

***

## Making Assignments 

### GitHub

1. Create a private assignment repo that contains any starter documents you wish to provide for the students. For example, the repo could contain the following: 
    
    - R Markdown template for students to fill in their responses. 
    - Any data required to complete the assignment in a `/data` sub folder. 
    - README that includes link to assignment instructions. 
   
2. Use the `ghclass` package to create individual or team student repos that are mirrors of the original assignment repo. See [Creating a team assignment](https://rundel.github.io/ghclass/articles/ghclass.html) in [@ghclass] to step-by-step instructions. 

    By default these repos will be private. 

3. Students clone the repo into RStudio to complete the assignment. 

### RStudio Cloud

1. Create a new project in the course workspace. In the project, include any R Markdown templates, R scripts, data sets, and any other documents the students will need to complete the assignment or activity. 

2. In the project options, click "Everyone" for "Who can view this project". This will make the project visible to every member of the course workspace. 

3. Students can make a copy of the project and can complete the assignment in their copy. 


*** 

## Additional Resources

- [Tech Talk: Frictionless onboarding to data science with RStudio Cloud](https://www.causeweb.org/cause/ecots/ecots18/tech-talk/4): information on using RStudio Cloud in your classroom. 

- [*Happy Git with R*](https://happygitwithr.com/): information on using Git, Github and RStudio.
