using Atlas.Domain;
using NetArchTest.Rules;
using Xunit;

namespace Atlas.ArchitectureTests;

public sealed class LayerDependencyTests
{
    private static readonly string DomainNamespace = typeof(DomainAssemblyMarker).Namespace!;

    [Fact]
    public void Domain_ShouldNot_DependOn_Infrastructure()
    {
        var result = Types.InAssembly(typeof(DomainAssemblyMarker).Assembly)
            .ShouldNot()
            .HaveDependencyOn("Atlas.Infrastructure")
            .GetResult();

        Assert.True(result.IsSuccessful, FormatFailure(result, "Domain → Infrastructure"));
    }

    [Fact]
    public void Domain_ShouldNot_DependOn_Application()
    {
        var result = Types.InAssembly(typeof(DomainAssemblyMarker).Assembly)
            .ShouldNot()
            .HaveDependencyOn("Atlas.Application")
            .GetResult();

        Assert.True(result.IsSuccessful, FormatFailure(result, "Domain → Application"));
    }

    [Fact]
    public void Domain_ShouldNot_DependOn_Api()
    {
        var result = Types.InAssembly(typeof(DomainAssemblyMarker).Assembly)
            .ShouldNot()
            .HaveDependencyOn("Atlas.Api")
            .GetResult();

        Assert.True(result.IsSuccessful, FormatFailure(result, "Domain → Api"));
    }

    private static string FormatFailure(TestResult result, string rule) =>
        $"Architecture violation [{rule}]: {string.Join(", ", result.FailingTypeNames ?? [])}";
}
