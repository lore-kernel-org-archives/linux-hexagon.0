Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E6F1CAA7B;
	Mon,  3 Feb 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738566006; cv=none; b=hYBPSpj+8os550KSE35HNCiPjFsWdStB5TznB+5qwBEiBki8DPYGRNcZuHge1/8nSb+CS0NNQmPp2Us2xw02/GWZmnqGX3YwmvujihbZCpI5LqBr94kb+IbYzD7yLdxiS2Ftlkl0N1yxfWGxlJ//2LPLmvtAMUS2XCElQ3TKqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738566006; c=relaxed/simple;
	bh=fdqHQZGWuHOq3XePPUM8hh4SDG8b30r6PO72C50P2/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JkGV9tK275pkr+H6Vzl7UM3XVpKbCy7sgUxk1LKafxheo9LsEajV6FwrnykL1roj0satDyRl/pPC98J+xoGG6IzzuS+MsifP6ljj4RjNCF+WRFsJhnFi+IpN/geL3q0DXtuoWft4+qTpvQsnSDg97UdOplcA3fBi1F3aHaLSKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id C198472C8FB;
	Mon,  3 Feb 2025 10:00:03 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id B519E7CCB3A; Mon,  3 Feb 2025 09:00:03 +0200 (IST)
Date: Mon, 3 Feb 2025 09:00:03 +0200
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
Subject: [PATCH v4 2/7] hexagon: add syscall_set_return_value()
Message-ID: <20250203070003.GC14120@strace.io>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203065849.GA14120@strace.io>

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
