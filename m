Return-Path: <linux-hexagon-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F658C4332F
	for <linux-hexagon@archiver.kernel.org>; Sat,  4 Nov 2023 09:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjKDJQk (ORCPT
        <rfc822;linux-hexagon@archiver.kernel.org>);
        Sat, 4 Nov 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJQj (ORCPT
        <rfc822;linux-hexagon@vger.kernel.org>);
        Sat, 4 Nov 2023 05:16:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AB9D47
        for <linux-hexagon@vger.kernel.org>; Sat,  4 Nov 2023 02:16:35 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7788db95652so185907185a.2
        for <linux-hexagon@vger.kernel.org>; Sat, 04 Nov 2023 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699089394; x=1699694194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZsOGiaArG1gPfWJWYyqQWKmeMDqaJOsSKH43M0pjNo=;
        b=Q/U+dBHCPN+0cYxnzGDmOICtLzHegbWb2rExRSc9m0SSrRRG/7baJ4tiI/SuE1VeqH
         qa04UYbzXRvAmHv4GrOQeX3yscLfaLpWQ2YJE1PGNR1RhnTWdLz2K5FtdR6LygDxgSKa
         OCO/cQoCIsErOX7ebeTijU44VG1x7Xm8FEgn4okcW0i1cy/TJNSFy+k4mIcprYXnUg8E
         DVIgD2k46XlA4PGlthjXDyoL0LcjTC0J0I5BEkmgDVLFUP0Whel+xniIuj6s7kLFQiPu
         634TCks3uHSlEuW9w10j0rQ0kAkET7ZG3SO+JMLnafVcaH8zIzbmxo3KhPE3x/eGpOVS
         wwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089394; x=1699694194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZsOGiaArG1gPfWJWYyqQWKmeMDqaJOsSKH43M0pjNo=;
        b=gGEfzJqLjzYDGu9LS7Tq1N7MRq9oSvcI6NAHmwr4Ehp4e8rS6wVqpcAeo7beI+BHdn
         qbcycbhyATOdtLcFNpu3d/2aUrjb9k3YP0vcZdT3+aX5/jUzP8RAZs3H3tbWi5k9u+wn
         eGTkMN/kkZ7S/V+DkxEBDfFH5LU41/FMNlW3gSYtLGYPD4VNYaDIZx6DFlRnaEMu+/mE
         jJVrH+R2pYDhAsUsadzV6Yla+EZUZcSCXLqAswaqXufBNSLHq7EYb1xHlmQ2pM7UBMst
         w8dvw4efHYf88XuOZrORQnhsDDnkmXNUgkl6h11TUygi28lXh2JQCZ7RS2CeTOTiWiaS
         rp1g==
X-Gm-Message-State: AOJu0YxGKOY2ekaudSlNi+waoa7hAO7odeRbLi6L5FhYcFevh13QW0oY
        9hjVy5h7SEN/m8b150XWaFDswQ==
X-Google-Smtp-Source: AGHT+IGjAYKMZlAfEP3ECe1n3sw6IIECunrstOALu+CAcSUP9EdkfONAQy3WGvW0OrN94BxZJnCbWg==
X-Received: by 2002:a05:620a:2588:b0:777:2767:6465 with SMTP id x8-20020a05620a258800b0077727676465mr27504451qko.40.1699089394700;
        Sat, 04 Nov 2023 02:16:34 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001cc54202429sm2585127plh.288.2023.11.04.02.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:16:34 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     vgupta@kernel.org, bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        geert@linux-m68k.org, andi.shyti@linux.intel.com, mingo@kernel.org,
        palmer@rivosinc.com, andrzej.hajda@intel.com, arnd@arndb.de,
        peterz@infradead.orgm, mhiramat@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mattwu@163.com,
        linux@roeck-us.ne, "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v2 1/4] locking/atomic: arc: data size checking in arch_cmpxchg
Date:   Sat,  4 Nov 2023 17:16:12 +0800
Message-Id: <20231104091615.4884-2-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
References: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hexagon.vger.kernel.org>
X-Mailing-List: linux-hexagon@vger.kernel.org

Macro __cmpxchg() renamed to __cmpxchg_32() to emphasize it's explicit
support of 32bit data size, BUILD_BUG_ON() added to avoid any possible
misuses with unsupported data types.

In case CONFIG_ARC_HAS_LLSC is undefined, arch_cmpxchg() uses spinlock
to accomplish SMP-safety, so the BUILD_BUG_ON checking is uncecessary.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 arch/arc/include/asm/cmpxchg.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067de..bf46514f6f12 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -18,14 +18,16 @@
  * if (*ptr == @old)
  *      *ptr = @new
  */
-#define __cmpxchg(ptr, old, new)					\
+#define __cmpxchg_32(ptr, old, new)					\
 ({									\
 	__typeof__(*(ptr)) _prev;					\
 									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
+									\
 	__asm__ __volatile__(						\
-	"1:	llock  %0, [%1]	\n"					\
+	"1:	llock  %0, [%1]		\n"				\
 	"	brne   %0, %2, 2f	\n"				\
-	"	scond  %3, [%1]	\n"					\
+	"	scond  %3, [%1]		\n"				\
 	"	bnz     1b		\n"				\
 	"2:				\n"				\
 	: "=&r"(_prev)	/* Early clobber prevent reg reuse */		\
@@ -47,7 +49,7 @@
 									\
 	switch(sizeof((_p_))) {						\
 	case 4:								\
-		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
+		_prev_ = __cmpxchg_32(_p_, _o_, _n_);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -65,8 +67,6 @@
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
-	BUILD_BUG_ON(sizeof(_p_) != 4);					\
-									\
 	/*								\
 	 * spin lock/unlock provide the needed smp_mb() before/after	\
 	 */								\
-- 
2.40.1

