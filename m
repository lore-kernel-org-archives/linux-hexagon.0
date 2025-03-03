Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543351F3D30;
	Mon,  3 Mar 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000797; cv=none; b=Z8eS3WKiJ9/eJRYarqrRVjVuvl160OHEjEfpciCQVhxlgkXRH3aIHIDdU/F2QjWg0GEQ3b/ygQuVSrWbf0zcXozeVDJpbFSK9nbQdqt3HkZtR2hK5Z1ZIOgWg1yAPzapjXQ5p20BaS/LS+4Rop4weET7/oxIEB5Vt33JASs43so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000797; c=relaxed/simple;
	bh=fdqHQZGWuHOq3XePPUM8hh4SDG8b30r6PO72C50P2/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sp+mhLpibpUqdcZuCL/MGTqiN9XxGOWxEM7Lm4y0CnHMsoc3C/Uc9yRMRXcDncyAFFeZPMDrBX14UJDkfXKeO6BwNqGBavvkm52yWJUOCVod36bFOi7a0MOZY1hyF7Hnk+zbPt5tWmek10tLyE9LNTBumXw1Q65JuWT7sjxEjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2965272C8FB;
	Mon,  3 Mar 2025 14:19:54 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 209E97CCB3B; Mon,  3 Mar 2025 13:19:53 +0200 (IST)
Date: Mon, 3 Mar 2025 13:19:53 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Cain <bcain@quicinc.com>, Oleg Nesterov <oleg@redhat.com>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/6] hexagon: add syscall_set_return_value()
Message-ID: <20250303111953.GB24170@strace.io>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303111910.GA24170@strace.io>

hexagon is the only architecture that provides HAVE_ARCH_TRACEHOOK but
doesn't define syscall_set_return_value().  Since this function is going
to be needed on all HAVE_ARCH_TRACEHOOK architectures to implement
PTRACE_SET_SYSCALL_INFO API, add it on hexagon, too.

Signed-off-by: Dmitry V. Levin <ldv@strace.io>
---
 arch/hexagon/include/asm/syscall.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index f6e454f18038..951ca0ed8376 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -45,6 +45,13 @@ static inline long syscall_get_return_value(struct task_struct *task,
 	return regs->r00;
 }
 
+static inline void syscall_set_return_value(struct task_struct *task,
+					    struct pt_regs *regs,
+					    int error, long val)
+{
+	regs->r00 = (long) error ?: val;
+}
+
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_HEXAGON;
-- 
ldv
