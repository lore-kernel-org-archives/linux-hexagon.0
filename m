Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E416FF52
	for <linux-hexagon@vger.kernel.org>; Thu,  2 May 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671509; cv=none; b=c8SwUD1gg9DjC41Q7gaMZWATiyU3j86GxdbAfF1yCzaHv8CJOJezISb+JBXHnZZ9CvlIi68f5Hve+Rgm6XiJ3q7z5zfBHbqYHFISheeC5CNDbZw6YeFtM0jOrguMAKsdDLRGT8hlOR4wbx5LFdnVab546nLsolQMRnREgWrF1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671509; c=relaxed/simple;
	bh=GvwRPHoxtk/jezrpSCZ86ku2akWlX5bSrTJGDd347OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0KGtutZIXbUS2Dp0nxu3GC6J0aGIzHfsuqRAmdsHFAcGcYFzn1oMGSpjiXeaab1jEBfJ+c4O1O2Z6yAej3gU2ksF63z7Jpq7M5XFNcyRLX2MffPCQDAP/54Sw3+9GE99+7gCuwJdO9rolFCIM6uIA2k2W7Ge0uJuV1NbM4TEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J68kTnIX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J68kTnIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714671506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3JxNBtIIqVU4bz0zF1ZmAy1QkpyEGqwoMSlvusLpYz4=;
	b=J68kTnIXIQ8n4tyYTC3qmW37aGmc0/5txMvrsT8VUJmbAbZbqW+H9CrqcX+QS/wmkjfPwH
	BmTp64Ru7L0SdwRaW5KdEoPNYdfI216GTGi9e2/jQwWpZVUY9Ux1+dM2lcQMc6Zg3L6LZt
	1rlQ7wEWkS48KZadoe+hqh5AzJggyyQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-jV_WCGHFOX6v_SgVPx2G9Q-1; Thu, 02 May 2024 13:38:21 -0400
X-MC-Unique: jV_WCGHFOX6v_SgVPx2G9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31D78032FA;
	Thu,  2 May 2024 17:38:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B012DEC682;
	Thu,  2 May 2024 17:38:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-hexagon@vger.kernel.org
Subject: [PATCH] hexagon: Move kernel prototypes out of uapi/asm/setup.h header
Date: Thu,  2 May 2024 19:38:18 +0200
Message-ID: <20240502173818.58152-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The kernel function prototypes are of no use for userspace and
shouldn't get exposed in an uapi header, so let's move them into
an internal header instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/hexagon/include/asm/setup.h      | 20 ++++++++++++++++++++
 arch/hexagon/include/uapi/asm/setup.h | 14 ++------------
 2 files changed, 22 insertions(+), 12 deletions(-)
 create mode 100644 arch/hexagon/include/asm/setup.h

diff --git a/arch/hexagon/include/asm/setup.h b/arch/hexagon/include/asm/setup.h
new file mode 100644
index 000000000000..9f2749cd4052
--- /dev/null
+++ b/arch/hexagon/include/asm/setup.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ */
+
+#ifndef _ASM_HEXAGON_SETUP_H
+#define _ASM_HEXAGON_SETUP_H
+
+#include <linux/init.h>
+#include <uapi/asm/setup.h>
+
+extern char external_cmdline_buffer;
+
+void __init setup_arch_memory(void);
+
+#endif
diff --git a/arch/hexagon/include/uapi/asm/setup.h b/arch/hexagon/include/uapi/asm/setup.h
index 8ce9428b1583..598f74f671f6 100644
--- a/arch/hexagon/include/uapi/asm/setup.h
+++ b/arch/hexagon/include/uapi/asm/setup.h
@@ -17,19 +17,9 @@
  * 02110-1301, USA.
  */
 
-#ifndef _ASM_SETUP_H
-#define _ASM_SETUP_H
-
-#ifdef __KERNEL__
-#include <linux/init.h>
-#else
-#define __init
-#endif
+#ifndef _UAPI_ASM_HEXAGON_SETUP_H
+#define _UAPI_ASM_HEXAGON_SETUP_H
 
 #include <asm-generic/setup.h>
 
-extern char external_cmdline_buffer;
-
-void __init setup_arch_memory(void);
-
 #endif
-- 
2.44.0

