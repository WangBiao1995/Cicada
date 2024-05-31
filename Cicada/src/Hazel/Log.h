#pragma once

#include "spdlog/fmt/ostr.h"
#include "Core.h"
#include "spdlog/spdlog.h"
#include <memory.h>


namespace Hazel {
	class HAZEL_API Log {
	public:
		static void Init();
		inline static std::shared_ptr<spdlog::logger> & GetCoreLogger() { return s_CoreLogger; };
		inline static std::shared_ptr<spdlog::logger> & GetClinetLogger() { return s_ClientLogger; };

	private:
		static std::shared_ptr <spdlog::logger> s_CoreLogger;
		static std::shared_ptr<spdlog::logger> s_ClientLogger;

	};


}

//Core log macros
#define HZ_CORE_TRACE(...) ::Hazel::Log::GetCoreLogger()->trace(__VA_ARGS__);
#define HZ_CORE_INFO(...)  ::Hazel::Log::GetCoreLogger()->info(__VA_ARGS__);
#define HZ_CORE_WARN(...)  ::Hazel::Log::GetCoreLogger()->warn(__VA_ARGS__);
#define HZ_CORE_ERROR(...) ::Hazel::Log::GetCoreLogger()->error(__VA_ARGS__);
#define HZ_CORE_FATAL(...) ::Hazel::Log::GetCoreLogger()->critical(__VA_ARGS__);

//客服端日志宏
#define HZ_TRACE(...) ::Hazel::Log::GetClinetLogger()->trace(__VA_ARGS__);
#define HZ_INFO(...)  ::Hazel::Log::GetClinetLogger()->info(__VA_ARGS__);
#define HZ_WARN(...)  ::Hazel::Log::GetClinetLogger()->warn(__VA_ARGS__);
#define HZ_ERROR(...) ::Hazel::Log::GetClinetLogger()->error(__VA_ARGS__);
#define HZ_FATAL(...) ::Hazel::Log::GetClinetLogger()->critical(__VA_ARGS__);