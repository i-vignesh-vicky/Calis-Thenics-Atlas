using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore.ValueGeneration;
using UUIDNext;

namespace Atlas.Infrastructure.Persistence.ValueGenerators;

internal sealed class UuidV7ValueGenerator : ValueGenerator<Guid>
{
    public override bool GeneratesTemporaryValues => false;

    public override Guid Next(EntityEntry entry) => Uuid.NewDatabaseFriendly(Database.PostgreSql);
}
