#include <vcg/complex/complex.h>
#include <vcg/complex/algorithms/create/platonic.h>

#include <vcg/complex/complex.h>
#include <vcg/complex/algorithms/create/platonic.h>

#include <wrap/io_trimesh/export_off.h>

extern "C" {

using namespace std;
using namespace vcg;

// -------- dummy pinvoke tests ----------
double processTestNumberNative(double number)
{
  return number * 3;
}

//-----------------------types examples -----------------------------------------------------
class CFaceNormal;
class CVertexNormalRGBA;

struct CVCGLIBUsedTypes
  : public vcg::UsedTypes<vcg::Use<CVertexNormalRGBA>::AsVertexType, vcg::Use<CFaceNormal>::AsFaceType>
{
};

class CVertexNormalRGBA : public vcg::Vertex<CVCGLIBUsedTypes, vcg::vertex::Coord3f, vcg::vertex::Normal3f,
                                             vcg::vertex::Color4b, vcg::vertex::BitFlags>
{
};

class CFaceNormal
  : public vcg::Face<CVCGLIBUsedTypes, vcg::face::VertexRef, vcg::face::Normal3f, vcg::face::FFAdj, vcg::face::BitFlags>
{
};

class CMesh : public vcg::tri::TriMesh<std::vector<CVertexNormalRGBA>, std::vector<CFaceNormal> >
{
};
//-------------------- function examples --------------------------------------------------------

int createMeshTest()
{
  CMesh hexahedron;
  vcg::tri::Hexahedron(hexahedron);
  return hexahedron.vert.size();
}

// ---------------------------------------------------------------------------------------------
CMesh* CMesh_Create()
{
  return new CMesh();
}

void CMesh_Destroy(CMesh* mesh)
{
  delete mesh;
}

int CMesh_GetVN(const CMesh* mesh)
{
  return mesh->vert.size();
}

int CMesh_GetEN(const CMesh* mesh)
{
  return mesh->edge.size();
}

int CMesh_GetFN(const CMesh* mesh)
{
  return mesh->face.size();
}

int CMesh_GetHN(const CMesh* mesh)
{
  return mesh->HN();
}

int CMesh_GetTN(const CMesh* mesh)
{
  return mesh->TN();
}

void CMesh_AddVertex(CMesh* mesh, float x, float y, float z)
{
  CVertexNormalRGBA v;
  v.P() = vcg::Point3f(x, y, z);
  mesh->vert.push_back(v);
}

void CMesh_GetVertex(const CMesh* mesh, int index, float* x, float* y, float* z)
{
  if (index < mesh->vert.size())
  {
    const CVertexNormalRGBA& vertex = mesh->vert[index];
    *x = vertex.P().X();
    *y = vertex.P().Y();
    *z = vertex.P().Z();
  }
}

const CVertexNormalRGBA* CMesh_GetVerticesArray(const CMesh* mesh)
{
  return mesh->vert.data();  // Retorna un puntero al array de vértices
}

void CMesh_DeleteVertex(CMesh* mesh, int index)
{
  if (index < mesh->vert.size())
  {
    mesh->vert.erase(mesh->vert.begin() + index);
  }
}

void CMesh_AddFace(CMesh* mesh, int vertexIndex1, int vertexIndex2, int vertexIndex3)
{
  CFaceNormal f;
  f.V(0) = &mesh->vert[vertexIndex1];
  f.V(1) = &mesh->vert[vertexIndex2];
  f.V(2) = &mesh->vert[vertexIndex3];
  mesh->face.push_back(f);
}

void CMesh_GetFace(const CMesh* mesh, int faceIndex, int* vertexIndex1, int* vertexIndex2, int* vertexIndex3)
{
  if (faceIndex < mesh->face.size())
  {
    const CFaceNormal& face = mesh->face[faceIndex];
    *vertexIndex1 = vcg::tri::Index(*mesh, face.V(0));
    *vertexIndex2 = vcg::tri::Index(*mesh, face.V(1));
    *vertexIndex3 = vcg::tri::Index(*mesh, face.V(2));
  }
}

void CMesh_DeleteFace(CMesh* mesh, int faceIndex)
{
  if (faceIndex < mesh->face.size())
  {
    mesh->face.erase(mesh->face.begin() + faceIndex);
  }
}


//------------------------ high level functions -------------------------------------------------
CMesh* createIcosahedron()
{
  auto icosahedron =CMesh_Create();
  vcg::tri::Icosahedron(*icosahedron);
  return icosahedron;
}

// void delunayOptimization(CMesh* m)
// {
//       BaseParameterClass pp;
//       vcg::LocalOptimization<CMesh> FlippingSession(m,&pp);
//       FlippingSession.SetTargetMetric(0.0f);
//       FlippingSession.Init<MyDelaunayFlip >();
//       FlippingSession.DoOptimization();
// }

}
