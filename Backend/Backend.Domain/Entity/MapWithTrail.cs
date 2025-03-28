using Backend.Domain.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Domain.Entity
{
    public class MapWithTrail
    {
        public Trail Trail { get; set; }
        public Map Map { get; set; }
    }
}
