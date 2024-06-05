workspace "Cicada"
	architecture "x64"

	configurations{
		"Debug",
		"Relese",
		"Dist"
	}

	outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}" --eg:Debug-windows-x64

--Include directories relative to root folder(solution dir)
IncludeDir = {}
IncludeDir["GLFW"] = "Cicada/vendor/GLFW/include"
IncludeDir["Glad"] = "Cicada/vendor/Glad/include"
IncludeDir["ImGui"] = "Cicada/vendor/imgui"
include "Cicada/vendor/GLFW"  --����GLFW��premake�ļ����ݵ���ǰpremake�ļ���
include "Cicada/vendor/Glad"
include "Cicada/vendor/imgui"

project "Cicada"
	location "Cicada"
	kind "SharedLib"
	language "C++"

	targetdir("bin/"..outputdir .. "/%{prj.name}") --���Ŀ¼
	objdir("bin-int/"..outputdir .."/%{prj.name}") --�м�Ŀ¼

	files
	{
		"%{prj.name}/src/**.h",  
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/Platform/**.cpp",
		"%{prj.name}/Platform/**.h"
	}
	
	includedirs{
		"%{prj.name}/vendor/spdlog/include",
		"%{prj.name}/src",
		"%{prj.name}/Platform",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.Glad}"
	}

	links{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	pchheader "hzpch.h";
	pchsource "Cicada/src/hzpch.cpp"


	filter "system:windows"
		cppdialect "C++17"  --����c++���Ա�׼
		staticruntime "On" --ʹ�����п� static ����dynamic
		systemversion "latest" --windows SDK�汾

		defines{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}

		postbuildcommands{
			 "{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox"
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		buildoptions "/MDd"
		symbols "On"
    filter "configurations:Relese"
		defines "HZ_RELEASE"
		buildoptions "/MD"
		optimize "On"
	filter "configurations:Dist"
		defines  "HZ_DIST"
		buildoptions "/MD"
		optimize "On"
		


project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir("bin/"..outputdir .. "/%{prj.name}")
	objdir("bin-int/"..outputdir .."/%{prj.name}")

	files{

		"%{prj.name}/src/**.h",  
		"%{prj.name}/src/**.cpp",
	}
	
	includedirs{
		"Cicada/vendor/spdlog/include/",
		"Cicada/src"
	}

	filter "system:windows"
		cppdialect "C++17"  
		staticruntime "On" 
		systemversion "latest" 

		defines{
			"HZ_PLATFORM_WINDOWS",
		}

	links{
		"Cicada" 
	}	 


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		buildoptions "/MDd"
		symbols "On"
    filter "configurations:Relese"
		defines "HZ_RELEASE"
		buildoptions "/MD"
		optimize "On"
	filter "configurations:Dist"
		defines  "HZ_DIST"
		buildoptions "/MD"
		optimize "On"
		