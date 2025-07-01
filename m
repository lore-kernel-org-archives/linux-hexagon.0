Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3EA27815E;
	Tue,  1 Jul 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378206; cv=none; b=CsqPxeb2URXxDltlwzmufBxa4u+3wgwKu4CzfjwlI0AwAh7xA9unXJPtrmmj+zCTS4oLebcStM7CvMf5N5fxNSkbz2ySTaUXLrDnTWrHBjtFn0FgTt5op2Q2MOe1kE6o4FDnz50Bb59EPYZ0qETq6vw0VvdpEYM4NmIqun2X5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378206; c=relaxed/simple;
	bh=/shdMZwCV+KkBBiLg52KW5JwqpXSxghASPezdRQnh/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/hu4/l54Mly2RIv52VeCEQhJDJee/UnjqM1CK5XQz/WrhOjquDkRd5jIiGGuLsedkCnAnFCUJrKDmu90qh+0asGr27va7QruvFkv4PljOxV7BygAuJyecNXLLHqjT4cy4F961Z6SkoZOIwKaNePuYewZZzkkiEbKkpW8PP6p8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 799D726BC;
	Tue,  1 Jul 2025 06:56:29 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A78E93F58B;
	Tue,  1 Jul 2025 06:56:43 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Brian Cain <bcain@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	linux-hexagon@vger.kernel.org
Subject: [PATCH 08/23] hexagon: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
Date: Tue,  1 Jul 2025 14:56:01 +0100
Message-Id: <20250701135616.29630-9-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having the core code guess the note name for each regset,
use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Brian Cain <bcain@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-hexagon@vger.kernel.org
---
 arch/hexagon/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/ptrace.c b/arch/hexagon/kernel/ptrace.c
index 905b06790ab7..2093eee143e1 100644
--- a/arch/hexagon/kernel/ptrace.c
+++ b/arch/hexagon/kernel/ptrace.c
@@ -137,7 +137,7 @@ enum hexagon_regset {
 
 static const struct user_regset hexagon_regsets[] = {
 	[REGSET_GENERAL] = {
-		.core_note_type = NT_PRSTATUS,
+		USER_REGSET_NOTE_TYPE(PRSTATUS),
 		.n = ELF_NGREG,
 		.size = sizeof(unsigned long),
 		.align = sizeof(unsigned long),
-- 
2.34.1

