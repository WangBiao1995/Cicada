workspace "Cicada"
	architecture "x64"

	configurations{
		"Debug",
		"Relese",
		"Dist"
	}

	outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}" --eg:Debug-windows-x64

project "Cicada"
	location "Cicada"
	kind "SharedLib"
	language "C++"

	targetdir("bin/"..outputdir .. "/%{prj.name}") --���Ŀ¼
	objdir("bin-int/"..outputdir .."/%{prj.name}") --�м�Ŀ¼

	files{

		"%{prj.name}/src/**.h",  
		"%{prj.name}/src/**.cpp",
	}
	
	includedirs{
		"%{prj.name}/vendor/spdlog/include",
		"%{prj.name}/src"
	}

	filter "system:windows"
		cppdialect "C++17"  --����c++���Ա�׼
		staticruntime "On" --ʹ�þ�̬���ӣ����Ӹÿ�
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
		symbols "On"
    filter "configurations:Relese"
		defines "HZ_RELEASE"
		optimize "On"
	filter "configurations:Dist"
		defines  "HZ_DIST"
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
		systemversion "10.0.22000.0" 

		defines{
			"HZ_PLATFORM_WINDOWS",
		}

	links{
		"Cicada" 
	}	


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"
    filter "configurations:Relese"
		defines "HZ_RELEASE"
		optimize "On"
	filter "configurations:Dist"
		defines  "HZ_DIST"
		optimize "On"
		