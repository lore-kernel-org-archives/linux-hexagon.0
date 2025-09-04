Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512B270569;
	Thu,  4 Sep 2025 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967016; cv=none; b=m9GjmwZBW41JEmSEQ9vdKRBPs6jRCo8NVLCRtdKjQTjF6H9SDsG9/FFiBNR6MLwKHvrkFt1pmUoJAF3BbVXh25GiDdEaoJCpwtcJvFRrfMWuyHE0z1Au78kCgrTH+OtbdDbtj25Sri/zJ/Vsc7TJz4MlCJMWEqJhyahupmBSuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967016; c=relaxed/simple;
	bh=FtQO0Dbm2SXH3uBf0VSsa5xSivK0rkA6x4x2tRu/40I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFi+zNwv3S+h58nGvWFxW730615RhEyNHF8K48QTxPbLUmnqAUHKvrftVdWHyi45LQ5Rs7yGwJCFyGxEGwmVOotTFhHHcHbJhj6jbbl7HfJWlBcoiRNQo9HvxXu0U559bx921Fsmticm+LxIltkRgEKQTYzaf84Jg3Ni7OeLgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpd54IMD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpd54IMD"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7725d367d44so78377b3a.0;
        Wed, 03 Sep 2025 23:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756967014; x=1757571814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqScMWwsIOO4FF9xXYpH5H8Qrvhh65CN828Ff85nqcY=;
        b=Cpd54IMDkueiz3SvEJIrjKOXdj7SPykNZoSVYE1aR6uKA2qWMG4+iAVVyzUz0ppRh/
         5hH4NlURFclk5linauPyZOOFfcbc8BFD9PkVBF/4LKn8Z5mevdwPkTiiC2dj7Cqe1yrW
         DXbMeutOEL4rXmDRwQXntTxH6ot1WSjRkewsxykrtjWvn68PksnHpaHG1aoohBkL0qRq
         cFQLMbxuAzo9b3bcJkp0FFCr4XVKDwFKRg+S/mql+24+zomlTtNQD7QCSv4WtIZ+5qHM
         1ec1Av+7oIC/PCVpS9eQhAUikfX3AgKsdRpkt79vThSlA2Lc/FO2yhwbe+klNI42W0qm
         0EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967014; x=1757571814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqScMWwsIOO4FF9xXYpH5H8Qrvhh65CN828Ff85nqcY=;
        b=pPEfUMC5HM21UJYkfT73TdnKa4hs34yZyvoaY3akhVengNS2FTrEm7c0+g+nNsNWRy
         XLCR2JKK5cHlYdS9aPqeEdaTBtzrUfeRskewueJ+a8H3Wpi9jaPTkV4cW2iewsf1Noc1
         1AU2ZTEpjoOP8Qe0z6fOtuz4b4ZMIhDOX6GJbJTXR5e39Tr4eea/Jg8rLni7fg27Pbo2
         1u5AuxHxN8QuyGAEDZxCf+iIiHaTAYKtvxb0hxJ88pOn7PzNYeWqSrdIZt3e0ew4TY1n
         9ORpAHFdcfIHBLpfSCIcnpWo32GIk2yO+dGJow4nNs3O5ziYtnlkekUERGJMXt7q9Mry
         tpxA==
X-Gm-Message-State: AOJu0Yy5b0ohraK7+RVcqeSRxia2UZyM/dVvNWnXQ00Zj2BdNQcaN7xj
	dp92mhYZh/AeyAclx3PHVWExC64eOnSHTZcov0a2TbmGrE9t4UKmjSpOY5oxUFpy
X-Gm-Gg: ASbGncsHCUoqHm8mnrscgEEJR8w/rw6D0g9P41V/N2hKSTY50C/0FNJwWUZELJZEvzf
	X164lCr9Ku1RCSx2gLeY87f5gKIUu02kjefTGRyUNHfFRWnWnT5v4GEyjXw7iNnUZDo2zgRyRfc
	qfXip34eBoKUsj8rM94DPDmVrcL1GNQrOCupDRgGnsuLEAvghRrRjvpeMm6rew2QEbVHdteGKjb
	UvoW9yMpwh8VvVKB/OVGIpoxhHooz+BFJDqf+vy9kP3KloxnxxQopQgLiFTKsv3Asj+LuOKNXt0
	+nGcNWM3DwJ0cLZI8jWhqKMizKYY3Yh8BOtASeCP7j2cVoZ1eHdsQ3jsRQuSDeLtCYEuuaKvkPW
	Gkd3c9zgmid+Jh+xbtLiCAgQakVJA8hAIa35dVw==
X-Google-Smtp-Source: AGHT+IE3MI26sAwnImiGvLQXuXNemBNftGP4w8LXCGks2pKBnCEqIde5OjlQ7uQs5W6tzYw0B9IWqA==
X-Received: by 2002:a05:6a00:2290:b0:772:c3e:58ef with SMTP id d2e1a72fcca58-7723289dc3fmr13880730b3a.6.1756967013538;
        Wed, 03 Sep 2025 23:23:33 -0700 (PDT)
Received: from hobbes.T-mobile.com ([2600:70ff:f833:0:8e07:c9e8:902c:6ffa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f0c4008sm10198397b3a.35.2025.09.03.23.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:32 -0700 (PDT)
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Cain <bcain@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 1/2] Hexagon: change "a mm_struct" to "an mm_struct" in comment
Date: Wed,  3 Sep 2025 20:23:25 -1000
Message-ID: <4c3812e5903e4e91587eff3c37b7aee4b35ddf20.1756966290.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756966290.git.joeypabalinas@gmail.com>
References: <cover.1756966290.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct english is "an mm_struct" which is used everywhere else
in the kernel.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 arch/hexagon/include/asm/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/mmu.h b/arch/hexagon/include/asm/mmu.h
index dfa46660d695bb65b4..ce784218dc67c92a94 100644
--- a/arch/hexagon/include/asm/mmu.h
+++ b/arch/hexagon/include/asm/mmu.h
@@ -7,11 +7,11 @@
 #define _ASM_MMU_H
 
 #include <asm/vdso.h>
 
 /*
- * Architecture-specific state for a mm_struct.
+ * Architecture-specific state for an mm_struct.
  * For the Hexagon Virtual Machine, it can be a copy
  * of the pointer to the page table base.
  */
 struct mm_context {
 	unsigned long long generation;
-- 
Cheers,
Joey Pabalinas

