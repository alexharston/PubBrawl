from rpy2.robjects.packages import STAP

# Get R function from file
with open('./R/pubFinder.r', 'r') as f:
    r_functions = f.read()
    findPubs = STAP(r_functions, 'findPubs')

#### Test R function
key = 'AIzaSyBaNsBP0XxPQ3Y0V-WMf7fzj9ZSac2nzak'
#
# Start location
x_start = 51.534186
y_start = -0.138886
#
# End location
x_end = 51.517647
y_end = -0.119974

pubs = findPubs.findPubs(x_start, y_start, x_end, y_end, key)
print(pubs)
