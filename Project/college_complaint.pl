% =========================================================
% SMART COLLEGE COMPLAINT CLASSIFICATION SYSTEM
% Using Prolog
% =========================================================

:- use_module(library(readutil)).


% =========================================================
% 1. LOGIN DETAILS
% =========================================================

user("student@gmail.com", "1234").


% =========================================================
% 2. COMPLAINT FACTS
% =========================================================

complaint(wifi, technical).
complaint(internet, technical).
complaint(computer, technical).
complaint(software, technical).

complaint(projector, infrastructure).
complaint(classroom, infrastructure).
complaint(electricity, infrastructure).
complaint(building, infrastructure).
complaint(smell, infrastructure).

complaint(exam, examination).
complaint(marks, examination).
complaint(result, examination).
complaint(hallticket, examination).

complaint(hostel, hostel).
complaint(room, hostel).
complaint(food, hostel).
complaint(water, hostel).

complaint(bus, transport).
complaint(driver, transport).
complaint(timing, transport).

complaint(book, library).
complaint(library, library).
complaint(librarian, library).

complaint(fee, fees).
complaint(payment, fees).
complaint(scholarship, fees).

complaint(assignment, academic).
complaint(faculty, academic).
complaint(class, academic).
complaint(teaching, academic).


% =========================================================
% 3. DEPARTMENT FACTS
% =========================================================

department(technical, "IT Department").
department(infrastructure, "Maintenance Department").
department(examination, "Examination Department").
department(hostel, "Hostel Department").
department(transport, "Transport Department").
department(library, "Library Department").
department(fees, "Accounts Department").
department(academic, "Academic Department").
department(general, "Student Affairs Department").


% =========================================================
% 4. PRIORITY FACTS
% =========================================================

priority(technical, "Medium").
priority(infrastructure, "Medium").
priority(examination, "High").
priority(hostel, "Medium").
priority(transport, "Medium").
priority(library, "Low").
priority(fees, "High").
priority(academic, "Medium").
priority(general, "Low").


% =========================================================
% 5. CLASSIFICATION RULE
% =========================================================

classify(Keyword, Category, Department, Priority) :-
    complaint(Keyword, Category),
    department(Category, Department),
    priority(Category, Priority).


% =========================================================
% 6. LOGIN
% =========================================================

login :-
    nl,
    write('========================================'), nl,
    write('       COLLEGE COMPLAINT SYSTEM'), nl,
    write('========================================'), nl,

    write('Email: '),
    read_line_to_string(user_input, Email),

    write('Password: '),
    read_line_to_string(user_input, Password),

    (
        user(Email, Password)
        ->
        nl,
        write('Login Successful!'), nl,
        main_menu
        ;
        nl,
        write('Invalid Email or Password!'), nl,
        write('Please try again.'), nl,
        login
    ).


% =========================================================
% 7. MAIN MENU
% =========================================================

main_menu :-
    nl,
    write('========================================'), nl,
    write('              MAIN MENU'), nl,
    write('========================================'), nl,
    write('1. Submit Complaint'), nl,
    write('2. Classify Complaint'), nl,
    write('3. View Complaint Categories'), nl,
    write('4. View Departments'), nl,
    write('5. View Priority Information'), nl,
    write('6. Exit'), nl,
    write('========================================'), nl,

    write('Enter your choice: '),
    read_line_to_string(user_input, Choice),

    menu_choice(Choice).


% =========================================================
% 8. MENU CONTROL
% =========================================================

menu_choice("1") :-
    submit_complaint,
    main_menu.

menu_choice("2") :-
    classify_complaint,
    main_menu.

menu_choice("3") :-
    view_categories,
    main_menu.

menu_choice("4") :-
    view_departments,
    main_menu.

menu_choice("5") :-
    view_priorities,
    main_menu.

menu_choice("6") :-
    nl,
    write('========================================'), nl,
    write('Thank you for using the system!'), nl,
    write('Goodbye!'), nl,
    write('========================================'), nl.

menu_choice(_) :-
    nl,
    write('Invalid choice! Please enter 1 to 6.'), nl,
    main_menu.


% =========================================================
% 9. SUBMIT COMPLAINT
% =========================================================

submit_complaint :-
    nl,
    write('========================================'), nl,
    write('          SUBMIT COMPLAINT'), nl,
    write('========================================'), nl,

    write('Enter complaint keyword: '),
    read_line_to_string(user_input, Input),

    normalize_keyword(Input, Keyword),

    (
        classify(Keyword, Category, Department, Priority)
        ->
        show_result(Keyword, Category, Department, Priority)
        ;
        show_general_result(Keyword)
    ).


% =========================================================
% 10. CLASSIFY COMPLAINT
% =========================================================

classify_complaint :-
    nl,
    write('========================================'), nl,
    write('       COMPLAINT CLASSIFICATION'), nl,
    write('========================================'), nl,

    write('Enter complaint keyword: '),
    read_line_to_string(user_input, Input),

    normalize_keyword(Input, Keyword),

  (
    classify(Keyword, Category, Department, Priority)
    ->
    show_result(Keyword, Category, Department, Priority)
    ;
    show_general_result(Keyword)
).
% =========================================================
% 11. SHOW CLASSIFICATION RESULT
% =========================================================

show_result(Keyword, Category, Department, Priority) :-
    nl,
    write('----------- COMPLAINT RESULT -----------'), nl,

    write('Complaint  : '),
    write(Keyword),
    nl,

    write('Category   : '),
    write(Category),
    nl,

    write('Department : '),
    write(Department),
    nl,

    write('Priority   : '),
    write(Priority),
    nl,

    write('Status     : Pending'), nl,

    write('----------------------------------------'), nl.


% =========================================================
% 12. GENERAL COMPLAINT
% =========================================================

show_general_result(Keyword) :-
    nl,
    write('----------- COMPLAINT RESULT -----------'), nl,

    write('Complaint  : '),
    write(Keyword),
    nl,

    write('Category   : General'), nl,
    write('Department : Student Affairs Department'), nl,
    write('Priority   : Low'), nl,
    write('Status     : Pending'), nl,

    write('----------------------------------------'), nl.


% =========================================================
% 13. NORMALIZE INPUT
% =========================================================

normalize_keyword(Input, Keyword) :-
    string_lower(Input, LowerInput),
    normalize_space(string(CleanInput), LowerInput),
    atom_string(Keyword, CleanInput).


% =========================================================
% 14. VIEW CATEGORIES
% =========================================================

view_categories :-
    nl,
    write('========================================'), nl,
    write('         COMPLAINT CATEGORIES'), nl,
    write('========================================'), nl,

    write('1. Technical'), nl,
    write('2. Infrastructure'), nl,
    write('3. Examination'), nl,
    write('4. Hostel'), nl,
    write('5. Transport'), nl,
    write('6. Library'), nl,
    write('7. Fees'), nl,
    write('8. Academic'), nl,
    write('9. General'), nl,

    write('========================================'), nl.


% =========================================================
% 15. VIEW DEPARTMENTS
% =========================================================

view_departments :-
    nl,
    write('========================================'), nl,
    write('              DEPARTMENTS'), nl,
    write('========================================'), nl,

    write('Technical       -> IT Department'), nl,
    write('Infrastructure  -> Maintenance Department'), nl,
    write('Examination     -> Examination Department'), nl,
    write('Hostel          -> Hostel Department'), nl,
    write('Transport       -> Transport Department'), nl,
    write('Library         -> Library Department'), nl,
    write('Fees            -> Accounts Department'), nl,
    write('Academic        -> Academic Department'), nl,
    write('General         -> Student Affairs Department'), nl,

    write('========================================'), nl.


% =========================================================
% 16. VIEW PRIORITIES
% =========================================================

view_priorities :-
    nl,
    write('========================================'), nl,
    write('          PRIORITY INFORMATION'), nl,
    write('========================================'), nl,

    write('Technical       -> Medium'), nl,
    write('Infrastructure  -> Medium'), nl,
    write('Examination     -> High'), nl,
    write('Hostel          -> Medium'), nl,
    write('Transport       -> Medium'), nl,
    write('Library         -> Low'), nl,
    write('Fees            -> High'), nl,
    write('Academic        -> Medium'), nl,
    write('General         -> Low'), nl,

    write('========================================'), nl.


% =========================================================
% 17. START PROGRAM
% =========================================================

start :-
    login.
