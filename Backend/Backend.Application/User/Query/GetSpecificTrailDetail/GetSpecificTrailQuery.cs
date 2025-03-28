using Backend.Domain.Entity;
using Backend.Domain.Repository;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetSpecificTrailDetail
{
   public class GetSpecificTrailQuery:IRequest<Trail>
    {
        public int Id { get; set; }

    }
}
