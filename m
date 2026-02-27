Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257138A72F;
	Fri, 27 Feb 2026 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174288; cv=none; b=VVM56Tf3EcWufYGZFFLJYFOfwrXqCjlapBBs06p4fAAI+GKTfCYaJB5ZX2MliR4UVTbbn5MyBOWxKiDVWjvRmvX7peatd9SLNqwRfVQICaUOsY3Zcx+GnMF7BP6cCNxKT7WZi4WSBMF6jZVS9KJORXQG+zWJNo60i+7VdYf0jsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174288; c=relaxed/simple;
	bh=WrBEOu/3DYNHPKquP5T8Ii/d9NEtOfbY+cXD/rZpbug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUWFVUgMNrlOSEwjuOl2Yyw+2gdK9oAfCmkAKyIsMK8dfyBuZcNnqzvAbgBOmcfuTrShEyx4W21Vg6QIP68N2IDa+qEosgn3/MLp/zNcV1mckCHhkBcLLPA2w+Gry/proWSi+1WyA+l6xaa9De1zqhVmHjZ1B1UVwwb7qm0SRDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IEfMq7qA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IEfMq7qA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772174282;
	bh=WrBEOu/3DYNHPKquP5T8Ii/d9NEtOfbY+cXD/rZpbug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IEfMq7qAvaJk8u+grSElB5QGPzYlXi9KImyeul1riE9hav1SAQrD1MOaysIj5h3or
	 Wc/cTV9PFz3kv31tPXLzgzOHl9OSoEynjPuprbT4ztMRtluhfL1A8E9cEKhba5zfL4
	 qHfM2OFayBLrfZfcjvMhC0HzepwL9eRuPSqvZB94=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 27 Feb 2026 07:38:02 +0100
Subject: [PATCH 4/9] kbuild: uapi: completely exclude
 linux/bpf_perf_event.h on nios2
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-kbuild-uapi-libc-v1-4-c17de0d19776@weissschuh.net>
References: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
In-Reply-To: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772174282; l=877;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WrBEOu/3DYNHPKquP5T8Ii/d9NEtOfbY+cXD/rZpbug=;
 b=6ydhhvL2sXaaPBdR/AWv5pPpL/wqnWGDyboH8DssdZp1E3rM0WuL46aaRGVObdya1tgCP/zpY
 wZIIKj5p6sYCXSrQZ8AGVBJUdn74h2HUsCv+JcyUxQZPdzQVvm9LpRp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This header is actually not buildable on nios. As nobody built nios2
with CONFIG_CC_CAN_LINK=y so far, this produced no errors.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 usr/include/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index ae365d32269a..a8619aa85c87 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -48,7 +48,7 @@ no-header-test += xen/privcmd.h
 
 # More headers are broken in some architectures
 
-ifneq ($(filter arc openrisc xtensa, $(SRCARCH)),)
+ifneq ($(filter arc openrisc xtensa nios2, $(SRCARCH)),)
 no-header-test += linux/bpf_perf_event.h
 endif
 
@@ -128,7 +128,6 @@ endif
 
 ifeq ($(SRCARCH),nios2)
 uses-libc += asm/ptrace.h
-uses-libc += linux/bpf_perf_event.h
 endif
 
 ifeq ($(SRCARCH),s390)

-- 
2.53.0

