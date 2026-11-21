Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795235807;
	b=zQO/kMLcGbI2Fw2o8oFafrSE80Lxj+/zS1opd/n0MR99P/0GPncxuAIl2x1qLlh+Qx45
	 UvpS0WlXbB6g9mknvwl1aZw3UTXll4vJZZGvJSj2Y96K3XXBcDblgTv88eaw+r+igUqFy
	 WWR6IgX5A/11kyYCM7iSmEL6QLS411c1zaFO5ZDp3M0NeN1vF17xv9nFxidZS9jbxYTxN
	 emvC410ftXXZwK4aiSyEoQqbz92ocDiiVma/9HcIetZQDIHek2MSm1Om4anbGoDoUbjh2
	 opxr6Wmw0Qze4pc6xA6iX8BU1yQvRNCRCQ/Uw4Z5JWiYTOURQxAByIecvyNJu5khK2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795235807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=o+H2NfKElOKBXC0JjKSFjht+d0+DsV9I8ZA3m1AWoIY=;
	b=BzJudMtoqM0Wgfgq/dFxmrVv+v+JvW0ylD0uABeFXwjmIQSdVDNyKV8mZCOmkaUHA3QE
	 XCX5kncK/eH87ADCnQz05TNiu1PLXAypuO77no9FBUyBWYhy7UY6nqPLwD+rUhEsczEuv
	 CxUf93ocbz+QmfA0i2epljELTV8hTJ5OBI2UEWFrt4poO3msqWZlFaAUeq1Zi6hGteAen
	 wIilq75UX68Mc5acz/vw95pam+77/6ul3yyEH4R0OuOerUMauiLLdOF+0hEpXwEvTH7Qc
	 zN79r9xSiG1VmJnSro1eKmGCUOglQ3nQ2bzCuvng2mGsWyCUzbfsVhLfLCg14Yh5/Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4AaHr6N;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8C606A6BE
	for <linux-hexagon@vger.kernel.org>; Sat, 21 Nov 2026 04:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69E8C606A6BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4AaHr6N
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so644234b3a.0
        for <linux-hexagon@vger.kernel.org>; Fri, 20 Nov 2026 20:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795235805; x=1795840605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o+H2NfKElOKBXC0JjKSFjht+d0+DsV9I8ZA3m1AWoIY=;
        b=B4AaHr6NAFhJE+gsr+4lW5bFXKF4YN52dzHhclfshdB1jX3ZGcUCkEnMKN3t1Qikw+
         v2YBskK55JDi+Snn2vO/VuDyzFMlk6z34eO+KIvV+VZZvGMEY0xE1UcdwzV50wZHWtEh
         8rvVHbbHo9hKuZfIpDNDlZ1sR7qvPmFnUZsppnUUuui6qNMmewO1amcdsrthF2mmkX6c
         SJmRVi4nZYE4rVxoUWbs/KREgWybQFbmtI+nJ1JbYDieDaEqh5bdsV5jYpCDlgZhi/+I
         wrFww9Q+OoN3X5e0IHX3zQUPhIpbp/6b5YQKORpdCTEUrease7gEuysXiF7pIzyTPeD6
         J+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795235805; x=1795840605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o+H2NfKElOKBXC0JjKSFjht+d0+DsV9I8ZA3m1AWoIY=;
        b=T3YqfbjEpUD1+2LXRXL8BPs700WoSGNZixWSaXw1aFDmPqGnXdBWKVmhK18u5J659N
         3cXzapxSfiGboeXeawuGlDlfU6NeRsX7UMo64vXlhvIErmmF7J2GWhFdNcSmrnUFcTYj
         0UGGzlUV8HXn/diG+yX0VA+8OS5hJw5r3ZkMy/bN884V6fEFL6GtnKIlegjZZUCVIBXJ
         d+iqGhIhlhAOCKM+8XuV9kSGzrnvf/feLhwnrbq+N5spl1JtagASVniXDLt4Nk2VUqrk
         dMrtvEaOmSFuRnmD84TwytcIQvAGvfCePxnz2zszYJtA8qIH47onn8FLGRBjnfW7pkc0
         /hYA==
X-Gm-Message-State: APuU4Z/wcZ6kXEW178DL0hGPLs9EMA0iJjwAUNn/09VfD5KZzX2WPLPZ
	uhPLifsYbCMgVNgcT64CN2M67l2VsiH2jj3aikb+qY/gg3M8Uy50R0oc
X-Gm-Gg: AZFdTZeMKBr9xAb3bNJm59SIr/sQukhBu5JjJRDZbQ6rFbOopTginGMmByBTluSb03j
	AEmJqGE1GorY7lezRVkZmgwBs2BwPfasdI8iVidolFC/RlpAxtzpEpJSH+yC8+jAPnpsaFd/sDy
	NwM+5+D3WYsj1OsK8vee3tPQJmfeQcWBj9GMpAJzzGRIeen/VPiLa402ujQWWwYw2JZoB7F/lOV
	jypjXPflV7fdHSHYbcl1xwPR2U6sZIkzLNZb0fWPtKE8MvrfDZPAtnF6zEcMBuwYFPn6YvxeXf5
	e0A9etszCEeIvfwUftFA4tSPqgKheSngbqx0TN9s+yBhbo8TSc5OWlxdMyojfbdaONdKmq2Tw52
	zN99JQtINdcK2K0AOyQVZdTp8CSF/Hdi9TRQDbYTO9EJAudHRWxqqquZcH0gGmeDRCAEG+Ibksd
	wumWp+AYbPO+oCDJOgX0x8UIrDxm+4hMAHxxET2x8+cNk1Kyj9rk50YW2U8HasfA1VIvrpgntMy
	ibzLHOK9FEBxoxWQ5qsucmQ0zjtO5sZgPX5MsTKuxUomb3yh31AcL0rmIykEq67qAfSdgyhoWOs
	y4B+L4W6QodUrMkxixKcgZRm7Q54+/zGH9fp5rf+0s1BAKU6GAy75qY=
X-Received: by 2002:a05:6a00:2d28:b0:880:5fe5:a818 with SMTP id d2e1a72fcca58-8c87d80b5f6mr4598926b3a.59.1795235804614;
        Fri, 20 Nov 2026 20:36:44 -0800 (PST)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm2367221b3a.31.2026.11.20.20.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 20:36:43 -0800 (PST)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Brian Cain <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] hexagon: constant-extend head.S calls to out-of-file symbols
Date: Sat, 21 Nov 2026 12:36:36 +0800
Message-Id: <20261121043636.1296130-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Post: <mailto:linux-hexagon@vger.kernel.org>
List-Help: <mailto:linux-hexagon+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hexagon+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Cain <brian.cain@oss.qualcomm.com>

Every call in head.S before this point targets a symbol defined
elsewhere: __vmnewmap and __vmsetvec in vm_ops.S, memset in lib/, and
start_kernel in init/main.c.  The distance to each is whatever the
linker happens to lay out, not something the assembler can bound at
compile time.

The ld.lld versions used during this port have had bugs in exactly this
area -- miscalculating a compact PC-relative call's relocation range,
and not always synthesizing a trampoline when a call genuinely didn't
reach -- so a call that link-checks fine today is not a guarantee it
still will after the next relayout or the next linker. Constant-extend
all five so the encoding carries the full address and neither of those
failure modes is reachable, independent of link layout or which lld is
in use.

Without this, allmodconfig does not link with LLVM 17 and 18, as
ld.lld before 19.1.5 checks R_HEX_B22_PCREL against 2 MiB instead of
8 MiB [1] and the first four calls span 2.14 to 2.15 MiB in v7.4-rc1
with LLVM 17.0.1:

  ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):
  (.init.text+0xd4): relocation R_HEX_B22_PCREL out of range: 2242552
  is not in [-2097152, 2097151]; references '__vmnewmap'

Link: https://github.com/llvm/llvm-project/commit/64e3466fd09e [1]
Link: https://lore.kernel.org/all/20261119054908.2988120-1-shingekinocore@gmail.com/
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
[tzuching: rebase onto hexagon-fixes, describe the allmodconfig failure]
Tested-by: Tzu-Ching Yang <shingekinocore@gmail.com>
Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
---
Brian, as you agreed in your reply to my report, this is 09df35bd9d9f
from your hexagon-qemu-virt branch rebased onto hexagon-fixes
(0304683b4c43). The five changed lines are the same as yours; only the
context differs. I added the allmodconfig paragraph with the error
message and the two Link tags; please edit or drop them as you see
fit.

I did not add a stable tag; you may want to add one, as v7.3.4 fails
in the same way and v6.18.63 with LLVM 17.0.1 only. The patch applies
to both, and to v7.4-rc1 and next-20261113.

On each of these trees and on hexagon-fixes, the patch gives the
head.S I tested for the report linked in the changelog.

 arch/hexagon/kernel/head.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/kernel/head.S b/arch/hexagon/kernel/head.S
index 908ffece9132..cdd14403491b 100644
--- a/arch/hexagon/kernel/head.S
+++ b/arch/hexagon/kernel/head.S
@@ -119,7 +119,7 @@ ENTRY(stext)
 	 * vm_ops.S
 	 */
 	r1 = #VM_TRANS_TYPE_TABLE
-	call	__vmnewmap;
+	call	##__vmnewmap;
 
 	/*  Jump into virtual address range.  */
 
@@ -155,12 +155,12 @@ __head_s_vaddr_target:
 
 	r0 = r24
 	r1 = #VM_TRANS_TYPE_TABLE
-	call __vmnewmap
+	call ##__vmnewmap
 
 	/*  Go ahead and install the trap0 return so angel calls work  */
 	r0.h = #hi(_K_provisional_vec)
 	r0.l = #lo(_K_provisional_vec)
-	call __vmsetvec
+	call ##__vmsetvec
 
 	/*
 	 * OK, at this point we should start to be much more careful,
@@ -195,7 +195,7 @@ __head_s_vaddr_target:
 	{ r0.H = #HI(__bss_start);           r2.h = #HI(__bss_stop); }
 
 	r2 = sub(r2,r0);
-	call memset;
+	call ##memset;
 
 	/*  Set PHYS_OFFSET; should be in R25 */
 #ifdef CONFIG_HEXAGON_PHYS_OFFSET
@@ -205,7 +205,7 @@ __head_s_vaddr_target:
 #endif
 
 	/* Time to make the doughnuts.   */
-	call start_kernel
+	call ##start_kernel
 
 	/*
 	 * Should not reach here.

base-commit: 0304683b4c43048082483e9445fdd0691d088431
-- 
2.34.1

