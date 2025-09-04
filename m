Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA64267F59;
	Thu,  4 Sep 2025 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967013; cv=none; b=khoBjqQg7aYGTD1QUkRLeuTH4uMOw9Fza/Xt/HtQc21lVXz8atUzi1LQ7BQrj+pl5/yBqhqdbDCKhiNAXMOdn9VwPevaSj6p8f4fDZ5hNzCm3V8F3dzys5zFvoGEgYuVZn4KE8c9xhfS1U3r3D+DtQWrH0LsqdqwYNWBmxKh1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967013; c=relaxed/simple;
	bh=tCvX8yfQ6XU88f4dF6kcTOpr3Uk4qjaMwTxvSgE4FTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZrEoq0qUsaCo559SUb3NBwbibMNjjK2VAcfXIo/4a9H3ovuvSaFzPjbAXMrPWf/TYBgz+qjQy5JDQzhYhrUh367jvxaE8rZu0HLiz2Uo96j0UmCPbTZBBDmOabjAGEgEXgfdQYtxloXjaGMFnpZiHjN7K9MJ6SwvqfHAFtXc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsLqtJCA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsLqtJCA"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4fa75082a6so106938a12.1;
        Wed, 03 Sep 2025 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756967011; x=1757571811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iD9qXxSucOp/PG/eqVieT3odEBQZyOB1iznXz0xHs5E=;
        b=RsLqtJCAyZge+ZVsuAhXDceBSHsUJffUnpJWtek4jcWZd+muVz14g+4nlDZoYrNsfe
         bEqiC1eCYfc9yvoqf6NfwcsFZk0TetAn+slAy3FnCLAkrLUyzBN/9hcqUgpZ6WBAPgWQ
         v3uFua8mnEDnlhbO1xtQWC4XfI8qG1iKNCTd4MDA2nFHAzoirdcvVJuNPPRKhh+zNblU
         M+eYAvM1+0dRpAJL0+KZK0XlmCT7Xiv1OCXcja4+u0GgPoqfOFjSh4MJGJwGqE6qpdMX
         GTHfkhXRzPGoPgHRFG8J79MqLBejLZaX9T4fuqJZd8lGIyoU+o1baWKHJ6ZHBplIpRCv
         j7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967011; x=1757571811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD9qXxSucOp/PG/eqVieT3odEBQZyOB1iznXz0xHs5E=;
        b=LHeY7lj+RwprBiNXnTHSbaiLcFy31N/bElptNbNOMhvGNFB5u2CIPodP3xMn1MKcUf
         Reu5Lvs1sYXLhVPOzxCIjGfoNHRHWu2eobofPIZF8HZ8Vk/p6V2DDwMcz5BCyLDH3y/9
         exGEBaeJuVc8dxHZuvyT6tPYYN5b8WrfltLZKNq5EfQ5jSjv3rXt7jSy1fKcC8D8duSH
         KciZ+nDaGlt27KlK1GC2nV9H/C4IPw8kZhgCODgFTsob4XG50UQQcvhJZAeOQca2/ZNs
         x2JwNuAwa/6LLnarEmyvX84Z6KCoidKhKUxHeT1S/BaK+111JideuEFd72Og8pl73Q2R
         pjjQ==
X-Gm-Message-State: AOJu0YzvnXgJDSJjvMu2V33VoMjP6ZpdE4Xb8i6MHrffnV9sfxv7bHRd
	ceGbFfX79vhSzHKOaEX6bAlwHIyTCEgfcoOalvJ1qcRRjiIBWgwPjnIGY402WjBN
X-Gm-Gg: ASbGncuullbkjLGqgJDSYV99YVNuJsl6H08d4Cqep9XarX3Bg3I6Owcn1TpKzO+immt
	NIJTi88rQLt2eWXfXLbuZ6/jMuc6jZUCSex+vgWjAubCiamhvYcQ1odD3Hu6Ht03pdv83MW9gI7
	snX3NAb9x6iUwoAnfGC4EKf1moTmqiJzBqS4OeOzVXi21FKXdUzyd/1Tmj9CKQ1CXSYvexhNemn
	aUGoRXHheprxxlGqrBMydWveHVC9eWej8bstLp7HBXtkIpU9ZTgrm1gdB/QaDcxPQW0y7uk9+Pw
	3zHBd8Z04SpX4xDQs30ORX02c/onkZygh846Gi/RAoikMZkGcIqW+QUFjhtoxXn5bYPBLlqIByc
	qMIVNQV8V7PyiZXZoWjy+8g9E7S39/92AmR83Xg==
X-Google-Smtp-Source: AGHT+IGMQlpjlHcvnMvknLAgcjlNDxqZvomUwOkb55yXc59yTQ6MZCBiaASIEV/7XtM6qZ3h75IdOQ==
X-Received: by 2002:a05:6a00:10c7:b0:772:db8:9de5 with SMTP id d2e1a72fcca58-7723299b526mr15406179b3a.7.1756967010841;
        Wed, 03 Sep 2025 23:23:30 -0700 (PDT)
Received: from hobbes.T-mobile.com ([2600:70ff:f833:0:8e07:c9e8:902c:6ffa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f0c4008sm10198397b3a.35.2025.09.03.23.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:29 -0700 (PDT)
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Cain <bcain@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 0/2] change "a mm_struct" to "an mm_struct" in comment
Date: Wed,  3 Sep 2025 20:23:24 -1000
Message-ID: <cover.1756966290.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct english is "an mm_struct" which is used everywhere else
in the kernel.

Joey Pabalinas (2):
  Hexagon: change "a mm_struct" to "an mm_struct" in comment
  fork: change "a mm_struct" to "an mm_struct" in comment

 arch/hexagon/include/asm/mmu.h | 2 +-
 kernel/fork.c                  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
Cheers,
Joey Pabalinas

