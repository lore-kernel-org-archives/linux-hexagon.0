Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6443CF1FC;
	Wed, 19 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121123; cv=none; b=e/QpCUwy7z9iSviEQpEcPJOjsXQRhv8nTCFD70Ro/6quEkv0mDyAiGky6rTk4ursggkw2YN9LZqYxs0YULuudR/Bb8fB0xbDKbSNAnWiXxntNddPjmwLh598YLSDjErB5Nu60zlW/jCcEHVTqh+FHnJvgvh9ycy6VD8tQ93v2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121123; c=relaxed/simple;
	bh=DVViftVIIdCuHyyNK4ea0Py1AfEXtBP0DSlioEFw/1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqodRIRRQwj7CpLLPTlHpY85spPxVh86IBDvAEgLYAycKxoBecA1/QFB/c9CAS46DeC89uCdi/CUjXYs2hvpbcGL4KScrpu5t5WxA07QUdwmw+AS26Xv4xMzgTcekN37AQIOZTscQT5FECD8Rf9XHIqc9eGOBzQkNLHk2V9Ffuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HHjSu6G3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HHjSu6G3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1787121118;
	bh=DVViftVIIdCuHyyNK4ea0Py1AfEXtBP0DSlioEFw/1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HHjSu6G3vaqad+kU8jd0/y9t8h3HmfoOzsjk3JsKGvT7DCXpRr66dIvzAJdmaVI1R
	 6JGmsfyWV9xBU4seRstN+cOs6a4KQ0b5wwiDiYk55PuhBoamLCfsQQKVjB47DkKja1
	 7pypwgeNCFCPPk4Z3eJVOetQxiAsjQuy4Tj6zhRo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 19 Aug 2026 08:31:53 +0200
Subject: [PATCH 3/3] tools/nolibc: add support for hexagon
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-nolibc-hexagon-v1-3-6bc3be591f09@weissschuh.net>
References: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
In-Reply-To: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
To: Brian Cain <bcain@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787121117; l=12136;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DVViftVIIdCuHyyNK4ea0Py1AfEXtBP0DSlioEFw/1k=;
 b=rwGFoW39W3+QZP1ITSeRzyjfQvu/GtlICU8m2owm5tCLuzN582QHMdaLUdsTZXvTVQ56TsAdR
 GITDWY4iEoKAfQfubv27d8t2/AiTK1bduN1HKlSf02Ux8nS7McRnhRC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A mostly straightforward new architecture with a few quirks:
* Only qemu-user is supported for testing.
* Clang is required for compilation.
* -fsanitize=undefined is broken.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile                  |   1 +
 tools/include/nolibc/arch-hexagon.h            | 164 +++++++++++++++++++++++++
 tools/include/nolibc/arch.h                    |   2 +
 tools/testing/selftests/nolibc/Makefile.nolibc |   8 ++
 tools/testing/selftests/nolibc/run-tests.sh    |   6 +
 5 files changed, 181 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index b5897b3964f8..c4a0879e4140 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -21,6 +21,7 @@ architectures := \
 		alpha \
 		arm \
 		arm64 \
+		hexagon \
 		loongarch \
 		m68k \
 		mips \
diff --git a/tools/include/nolibc/arch-hexagon.h b/tools/include/nolibc/arch-hexagon.h
new file mode 100644
index 000000000000..2dcc69a47e9f
--- /dev/null
+++ b/tools/include/nolibc/arch-hexagon.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * hexagon specific definitions for NOLIBC
+ * Copyright (C) 2026 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_ARCH_HEXAGON_H
+#define _NOLIBC_ARCH_HEXAGON_H
+
+#include <linux/unistd.h>
+
+#include "compiler.h"
+#include "crt.h"
+
+/*
+ * Syscalls for OpenRISC:
+ *   - syscall number is passed in r6
+ *   - arguments are in r0, r1, r2, r3, r4, r5
+ *   - the system call is performed by calling trap0(#1)
+ *   - syscall return value is in r0
+ */
+
+#define _NOLIBC_SYSCALL_CLOBBERLIST "memory"
+
+#define __nolibc_syscall0(num)                                                \
+({                                                                            \
+	register long _num __asm__ ("r6") = (num);                            \
+	register long _arg1 __asm__ ("r0");                                   \
+									      \
+	__asm__ volatile (                                                    \
+		"trap0(#1)\n"                                                 \
+		: "=r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define __nolibc_syscall1(num, arg1)                                          \
+({                                                                            \
+	register long _num __asm__ ("r6") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap0(#1)\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define __nolibc_syscall2(num, arg1, arg2)                                    \
+({                                                                            \
+	register long _num __asm__ ("r6") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap0(#1)\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2),                                                 \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define __nolibc_syscall3(num, arg1, arg2, arg3)                              \
+({                                                                            \
+	register long _num __asm__ ("r6") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap0(#1)\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3),                                     \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define __nolibc_syscall4(num, arg1, arg2, arg3, arg4)                        \
+({                                                                            \
+	register long _num __asm__ ("r6") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap0(#1)\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define __nolibc_syscall5(num, arg1, arg2, arg3, arg4, arg5)                  \
+({                                                                            \
+	register long _num __asm__ ("r6") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap0(#1)\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define __nolibc_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)            \
+({                                                                            \
+	register long _num __asm__ ("r6") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("r5") = (long)(arg6);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap0(#1)\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#ifndef NOLIBC_NO_RUNTIME
+/* startup code */
+void __attribute__((weak, noreturn))
+__nolibc_entrypoint __nolibc_no_stack_protector
+_start(void)
+{
+	__asm__ volatile (
+		"r0 = sp\n"                 /* save stack pointer to r0, as arg1 of _start_c */
+		"call _start_c\n"           /* transfer to c runtime                        */
+	);
+	__nolibc_entrypoint_epilogue();
+}
+#endif /* NOLIBC_NO_RUNTIME */
+
+static __attribute__((unused))
+int _sys_ftruncate64(int fd, uint32_t length0, uint32_t length1)
+{
+	return __nolibc_syscall4(__NR_ftruncate64, fd, 0, length0, length1);
+}
+#define _sys_ftruncate64 _sys_ftruncate64
+
+#endif /* _NOLIBC_ARCH_HEXAGON_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 06cc2dbe7a33..24e0ec4fb2db 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -34,6 +34,8 @@
 #include "arch-parisc.h"
 #elif defined(__alpha__)
 #include "arch-alpha.h"
+#elif defined(__hexagon__)
+#include "arch-hexagon.h"
 #else
 #error Unsupported Architecture
 #endif
diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index f70c8dfca018..439677cbc5cf 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -206,6 +206,8 @@ CFLAGS_mips64be = -EB -mabi=64 -march=mips64r2
 CFLAGS_loongarch = $(if $(LLVM),-fuse-ld=lld)
 CFLAGS_sparc32 = $(call cc-option,-m32) -mcpu=v8
 CFLAGS_sh4 = -ml -m4
+# github.com/llvm/llvm-project/issues/216765
+CFLAGS_hexagon = -fno-sanitize=undefined
 ifeq ($(origin XARCH),command line)
 CFLAGS_XARCH = $(CFLAGS_$(XARCH))
 endif
@@ -222,6 +224,12 @@ LDFLAGS :=
 # Modify CFLAGS based on LLVM=
 include $(srctree)/tools/scripts/Makefile.include
 
+ifeq ($(ARCH),hexagon)
+# tools/scripts/Makefile.include requires CROSS_COMPILE which does not exist for hexagon
+CFLAGS += --target=hexagon-linux-musl
+CLANG_CROSS_FLAGS += --target=hexagon-linux-musl
+endif
+
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
 		/^Total number of errors:/{done++} \
 		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 5732b956ead9..3da806e2b302 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -31,6 +31,7 @@ all_archs=(
 	sh4
 	parisc32
 	alpha
+	hexagon
 )
 archs="${all_archs[@]}"
 
@@ -134,6 +135,7 @@ crosstool_abi() {
 
 need_gcc() {
 	case "$1" in
+	hexagon);;
 	*) echo "1";;
 	esac
 }
@@ -212,6 +214,10 @@ test_arch() {
 		echo "Unsupported configuration"
 		return
 	fi
+	if [ "$arch" = "hexagon" ] && [ -z "$llvm" -o "$test_mode" = "system" ]; then
+		echo "Unsupported configuration"
+		return
+	fi
 
 	mkdir -p "$build_dir"
 	swallow_output "${MAKE[@]}" defconfig

-- 
2.55.0

