from dolfin import *
import numpy as np

# Create mesh and define function space
mesh = Mesh("Cannie_x.xml")
V = FunctionSpace(mesh, "CG", 1)

# Load text file
group=np.loadtxt("Cannie_DB_dx.txt")

# Define variational problem
u = TrialFunction(V)
v = TestFunction(V)
f = Constant(0.0)
a = dot(grad(u), grad(v))*dx
L = f*v*dx


def DirichletBC_On_Vertices(mesh,group,V,num):  
    bc=[]
    index=-1
    for vertex in vertices(mesh):
        index=index+1
        interidex=int(group[index,0])
        if interidex==num:
            c=group[index,1]
            StringList="near(x[0],"+\
                str(vertex.point().x())+\
                ") && near(x[1],"\
                +str(vertex.point().y())+\
                ") && near(x[2],"+\
                str(vertex.point().z())+")"
            bc.append(DirichletBC(V,c,StringList,method="pointwise"))
            print (index,StringList)
    return bc

num=1
bc0 = DirichletBC_On_Vertices(mesh,group,V,num)


# Set PETSc MUMPS paramter (this is required to prevent a memory error
# in some cases when using MUMPS LU solver).
if has_petsc():
    PETScOptions.set("mat_mumps_icntl_14", 40.0)

# Compute solution
u = Function(V)
solve(a == L, u, bc0)
#u.rename('u', 'solution field')



# Compute gradient
#V_vec = VectorFunctionSpace(mesh, "CG", 1)
#gradu = project(grad(u),V_vec)

#V_g = VectorFunctionSpace(mesh, "CG", 1)
#v = TestFunction(V_g)
#w = TrialFunction(V_g)

#a = inner(w, v)*dx
#L = inner(grad(u), v)*dx
#grad_u = Function(V_g)
#solve(a == L, grad_u)

#grad_u.rename('grad(u)', 'continuous gradient field')


#grad_u_x, grad_u_y, grad_u_z = grad_u.split(deepcopy=True)  # extract components
#grad_u_x.rename('grad(u)_x', 'x-component of grad(u)')
#grad_u_y.rename('grad(u)_y', 'y-component of grad(u)')
#grad_u_z.rename('grad(u)_z', 'z-component of grad(u)')


# Write solution to file
File("CaninetoDB_dx.pvd") << u
#File("poisson_gradu.pvd") << grad_u
#File("DB_poisson_gradu.pvd") << gradu

#File("poissongrad_u_x.pvd") << grad_u_x
#File("poissongrad_u_y.pvd") << grad_u_y
#File("poissongrad_u_z.pvd") << grad_u_z



