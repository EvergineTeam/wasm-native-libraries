using System.Runtime.InteropServices;

namespace VCGLib;

public class VCGLibFacade
{
    const string DLL_NAME = "libvcglib_facade";

    public double procesTestNumber(double number) => number * 2;

    [DllImport(DLL_NAME)]
    public static extern double processTestNumberNative(double number);

    [DllImport(DLL_NAME)]
    public static extern int createMeshTest();

    [DllImport(DLL_NAME)]
    public static extern IntPtr createIcosahedron();
}

public class VCGLibMesh : IDisposable
{
    private IntPtr _meshPtr;

    const string DLL_NAME = "libvcglib_facade";

    private VCGLibMesh()
    {
        
    }

    [DllImport(DLL_NAME)]
    private static extern IntPtr CMesh_Create();

    [DllImport(DLL_NAME)]
    private static extern void CMesh_Destroy(IntPtr mesh);

    [DllImport(DLL_NAME)]
    private static extern int CMesh_GetVN(IntPtr mesh);

    [DllImport(DLL_NAME)]
    private static extern int CMesh_GetEN(IntPtr mesh);

    [DllImport(DLL_NAME)]
    private static extern int CMesh_GetFN(IntPtr mesh);

    [DllImport(DLL_NAME)]
    private static extern int CMesh_GetHN(IntPtr mesh);

    [DllImport(DLL_NAME)]
    private static extern int CMesh_GetTN(IntPtr mesh);

    [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
    private static extern void CMesh_AddVertex(IntPtr mesh, float x, float y, float z);

    [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
    private static extern void CMesh_GetVertex(
        IntPtr mesh,
        int index,
        out float x,
        out float y,
        out float z
    );

    [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
    private static extern IntPtr CMesh_GetVerticesArray(IntPtr mesh);

    [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
    private static extern void CMesh_DeleteVertex(IntPtr mesh, int index);

    [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
    private static extern void CMesh_AddFace(
        IntPtr mesh,
        int vertexIndex1,
        int vertexIndex2,
        int vertexIndex3
    );

    [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
    private static extern void CMesh_GetFace(
        IntPtr mesh,
        int faceIndex,
        out int vertexIndex1,
        out int vertexIndex2,
        out int vertexIndex3
    );

    [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
    private static extern void CMesh_DeleteFace(IntPtr mesh, int faceIndex);

    public int VN => CMesh_GetVN(_meshPtr);
    public int EN => CMesh_GetEN(_meshPtr);
    public int FN => CMesh_GetFN(_meshPtr);
    public int HN => CMesh_GetHN(_meshPtr);
    public int TN => CMesh_GetTN(_meshPtr);

    public void AddVertex(float x, float y, float z)
    {
        CMesh_AddVertex(_meshPtr, x, y, z);
    }

    public (float x, float y, float z) GetVertex(int index)
    {
        CMesh_GetVertex(_meshPtr, index, out float x, out float y, out float z);
        return (x, y, z);
    }

    public void DeleteVertex(int index) => CMesh_DeleteVertex(_meshPtr, index);

    public void AddFace(int vertexIndex1, int vertexIndex2, int vertexIndex3) =>
        CMesh_AddFace(_meshPtr, vertexIndex1, vertexIndex2, vertexIndex3);

    public (int vertexIndex1, int vertexIndex2, int vertexIndex3) GetFace(int faceIndex)
    {
        CMesh_GetFace(
            _meshPtr,
            faceIndex,
            out int vertexIndex1,
            out int vertexIndex2,
            out int vertexIndex3
        );
        return (vertexIndex1, vertexIndex2, vertexIndex3);
    }

    public void DeleteFace(int faceIndex) => CMesh_DeleteFace(_meshPtr, faceIndex);

    public void Dispose()
    {
        if (_meshPtr != IntPtr.Zero)
        {
            CMesh_Destroy(_meshPtr);
            _meshPtr = IntPtr.Zero;
        }
    }

    public override string ToString()
    {
        // return this._mesh pointer long value to string
        return ((long)this._meshPtr).ToString();
    }

    public static VCGLibMesh CreateEmptyMesh()
    {
        var mesh = new VCGLibMesh();
        mesh._meshPtr = CMesh_Create();
        return mesh;
    }

    public static VCGLibMesh CreateIcosahedron()
    {
        var mesh = new VCGLibMesh();
        var icosahedronPtr = VCGLibFacade.createIcosahedron();
        mesh._meshPtr = icosahedronPtr;
        return mesh;
    }
}
