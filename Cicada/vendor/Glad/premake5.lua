project "Glad"
	kind "StaticLib"
	language "C"
	warnings "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files{
		"include/glad/glad.h",  
		"include/KHR/khrplatform.h",
		"src/glad.c"
	}
	includedirs{
		"include"
	} --���Ӱ���Ŀ¼

	filter "system:windows"
		systemversion "latest"
		staticruntime "On"
    filter {"system:windows","configurations:Release"}
		buildoptions "/MT"
	