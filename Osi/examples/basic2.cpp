// Bare bones example of using COIN-OR OSI

#include <iostream>
#include OSIXXXhpp

int
main(void)
{
   // Create a problem pointer.  We use the base class here.
   OsiSolverInterface *si;

   // When we instantiate the object, we need a specific derived class.
   si = new OSIXXX;

   // Read in an mps file.  This one's from the MIPLIB library.
#if defined(SAMPLEDIR)
   si->readMps(SAMPLEDIR "/p0033");
#else
   fprintf(stderr, "Do not know where to find sample MPS files.\n");
   exit(1);
#endif

   // Solve the (relaxation of the) problem
   si->initialSolve();

   // Check the solution
   if ( si->isProvenOptimal() ) { 
      std::cout << "Found optimal solution!" << std::endl; 
      std::cout << "Objective value is " << si->getObjValue() << std::endl;

      int n = si->getNumCols();
      const double *solution;
      solution = si->getColSolution();
      // We could then print the solution or examine it.
   } else {
      std::cout << "Didn't find optimal solution." << std::endl;
      // Could then check other status functions.
   }

   return 0;
}
