Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738205;
	b=nONZStoNAw4d4Ttv/SKCW/wNa6Vvcd+cDAXzmtHPMK+m6fgNHp6NGfdPnaqRNow1Qu3C
	 aUGrv7CS+ZJZ9qHCBTDDKcKw+GuGw9Mune3D8lnXQXhLpWn/MG/JdfNrMaRTs9vVhkTui
	 JCnF87W2XtQTkux6Vq0OK5Qo1mjb23YWQs1JXAczIC1EQPJukc0u6LoytRO9JBl9RCokZ
	 gSmHv7q0J2wbsvTjx5jNQWc6yLP/L3y9XXbBR5Ecw9y574BnZ4pyvR4fMn9BG64dVsPSH
	 pUsRlyn48psNzSIr0YGWhfZxo/y6yOE/LGsOVUaN29mKQEu/tHsio5KCwp0WW2srSgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738205;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=4V7KDRv1Wx5A4y//DNy+CHoXqtEPoZTwtDcZqdg5DU8=;
	b=5IL8PMTTs4sAQoax5JXb6RL+HIzT7nM0apPdnXOEgxJReEVqYxCuSNPfzf4ZibKnXeuD
	 117SXXW0AOnll/w3I6KDylqfODVuiQtHCi3escIbOR74VP2APryjdw4AjPhgsbxINm+yU
	 Z7eQ88bhUGQ9tBCl/yE4U1/WMxwqzYpFhK6lvKfkAO6qEPOOyOB2UOdUs8HGHF7v5GmSe
	 9vAf3lI9hBv1Nw5/oBw/QynEuSw+T6AkWQMSuEjYbXM94bGGmRZgowcgeOo1mVP7c7i31
	 k/gIPxEg1TKi+5t/n6rgTzZ6QlQdSWfpSYlZpqLLug9HBAecgXvnmcaVeyzEskKRGQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P4+lfdfL;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3994606A326
	for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 06:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3994606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P4+lfdfL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792738203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4V7KDRv1Wx5A4y//DNy+CHoXqtEPoZTwtDcZqdg5DU8=;
	b=P4+lfdfLMcANQh2ccLWtv/B8Kz2TgxaLFHfUwXTah+9kISArCZyUsnvfEUmxxdEapdobm0
	cAicfY21+PnQEcQ7bwU68Ij/YrSNEs7bvPnmOlNoAbY/SxXKCgemgdNk0x8ZAOYUhpEhnn
	PDNbjXjs1J/CWxtuRdA21XrM+LG0TFU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-vCp2Rq0ONTKbWhaIDsK9Nw-1; Fri,
 23 Oct 2026 02:49:59 -0400
X-MC-Unique: vCp2Rq0ONTKbWhaIDsK9Nw-1
X-Mimecast-MFC-AGG-ID: vCp2Rq0ONTKbWhaIDsK9Nw_1792738197
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0685195607D;
	Fri, 23 Oct 2026 06:49:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E828519540C2;
	Fri, 23 Oct 2026 06:49:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Brian Cain <bcain@kernel.org>
Cc: soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-hexagon@vger.kernel.org
Subject: [PATCH v5 07/13] hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 23 Oct 2026 08:48:44 +0200
Message-ID: <20261023064908.66707-8-thuth@redhat.com>
In-Reply-To: <20261023064908.66707-1-thuth@redhat.com>
References: <20261023064908.66707-1-thuth@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/hexagon/include/uapi/asm/registers.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/uapi/asm/registers.h b/arch/hexagon/include/uapi/asm/registers.h
index d51270f3b3582..8f73d41651e87 100644
--- a/arch/hexagon/include/uapi/asm/registers.h
+++ b/arch/hexagon/include/uapi/asm/registers.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_REGISTERS_H
 #define _ASM_REGISTERS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*  See kernel/entry.S for further documentation.  */
 
@@ -224,6 +224,6 @@ struct pt_regs {
 	(regs)->hvmer.vmest = (HVM_VMEST_UM_MSK << HVM_VMEST_UM_SFT) \
 			    | (HVM_VMEST_IE_MSK << HVM_VMEST_IE_SFT)
 
-#endif  /*  ifndef __ASSEMBLY  */
+#endif  /*  ifndef __ASSEMBLER__  */
 
 #endif
-- 
2.56.0

