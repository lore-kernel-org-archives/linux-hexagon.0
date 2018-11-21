From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
Date: Wed, 21 Nov 2018 07:47:07 -0800 (PST)
Message-ID: <mhng-c75e14b8-b36c-46c2-8ffc-914312ed0cef@palmer-si-x1c4>
References: <20181121004422.GA29053@altlinux.org>
Mime-Version: 1.0 (MHng)
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:In-Reply-To:Subject:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=L6psVL98xfYZ8/uJ4NzZcqcSlhk2D4N+L+JF7WBk/WA=; b=QOv4OmcZjAt/bxlHxDLNbwCPA
	c3UVRs1jT+2b14FUoodGMvdd5go15Rf8RmvhMu0pExLQh3GO/1C4cuVSK5uZRdNmNX73KCtSEO2m1
	wEVzrFlNR5P4m4fQc5/HhCHMuWYKwI8B4iacIj9dRIdKmBhZ8XjwEoR3pEEnR4Ux4Upr5/tWfg3Wa
	dXPJ1qop78DQsopeeDxg+SH7C7tfRe4dXp5k4DwzEWlv1J82k84xXgN897OZHj/VNXCYgcWF0vLn1
	AsI3EBiLUU1Dw1hyYbTLtY93zmrgqOUAeEfdIRnyrWORkAnsqCug5tBXQ6mxEWfHr117mxaC7muzB
	IIALIM71A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=U/lY5CfdHLl3xwIXaQIRba/GPl3Jxhihr4NwbiVFjPo=;
 b=OwVpQ43CSWic4u6uy8EiX4jKWC+6GbIh1hQ2uLHBOxn55J2QmK/J9y7M7VBuV57UnY
 K/Y6wWyqTxEs/+0mJvSl8oBTR6DdKAncImadulVokxekAe/3eCZLhsPDMsVBkEGmRTim
 VhMmMIQ9LawdPvEMc+/jfP0vfTT5sGMvpwgW7YjNSR91NsdRxsY5l6VfXtoiH6n1bQhs
 4YWv+W4y84c8A81ySRAZ1JpUgGb+HJc+cxmhCe3H5swS7n4mRu0Do2Lv9ndTy+WsWV05
 aZWRazf5kGQCMZ2XjKUVV87al9jhGC6U6i14pP/eWICsOqELVHsriFVZmXp6TenE+Gp4
 c6Lg==
In-Reply-To: <20181121004422.GA29053@altlinux.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: ldv@altlinux.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, paul@paul-moore.com, linux-hexagon@vger.kernel.org, x86@kernel.org, esyr@redhat.com, lineprinter@altlinux.org, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, luto@kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, oleg@redhat.com, eparis@redhat.com, linux-audit@redhat.com, linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org

On Tue, 20 Nov 2018 16:44:22 PST (-0800), ldv@altlinux.org wrote:
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-audit@redhat.com
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: sparclinux@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: x86@kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
