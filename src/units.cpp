#include "units.hpp"

namespace Sass {

	double conversion_factors[5][5] = {
		         /* in      cm       mm       pt       pc */
		/* in */ { 1,      2.54,    25.4,    72,      6      },
		/* cm */ { 1/2.54, 1,       10,      72/2.54, 6/2.54 },
		/* mm */ { 1/25.4, 1/10,    1,       72/25.4, 6/25.4 },
		/* pt */ { 1/72,   2.54/72, 25.4/72, 1,       6/72   },
		/* pc */ { 1/6,    2.54/6,  25.4/6,  72/6,    1      }
	};

}