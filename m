From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
Date: Wed, 21 Nov 2018 07:15:15 -0800
Message-ID: <CALCETrV8AJPkZF7TzhXSte_wJgNXH+-s7-tPM-8xjcAfYgzdhg@mail.gmail.com>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gbf/ko+g923rM7WOnYJDgVqnjTV/I16vCW31YS1sb9o=; b=gZ4DI0eGcNp/A9
	DHwZFgB2IQpw5wzWugvUBbAEfc4YNGAJyAqdVA4xEAbwzE02BHk6yzjP382Bg6FK4lGo97Igy58Ku
	NAWD13YcwMOafgwdVO3S6cO+13zWUdbS50bfxD6oRb+pWBdTAtgOQRVZNj37fRAz8EtYongImPqF1
	FaDdk+J04BaEARZIx/vRZQ+uEajAXWVs0NvcmSmxFckSew9wfpVdpUKhQ2o1Mj5B//XnkV8IRDD9+
	zUg9DUJTe3u7FhmFCrQeN0bfviSAwOi27pH9YHX+/dRU5oDLSuOsFcZYGNpWbl++JpTXIYEXl8+/l
	sAtV9vaGmAigd1h1NOZg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542813329;
 bh=kpH9lcQ8P8XV+NLvUJEbt/IT04dFbPXjvuI1ObcBYAw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=khcwjnN3W8oiolVzWdkYwOXyQRAs6P6ySgIXzjCPjOfIH1gHQVWNjJgtidXHIgPRn
 CwCuMol6mW0iA++aIbUocbisf9NKWSLOFkbGX1rEZ7ryIkIhgsKBtW6vWIB93TttT3
 WJlKpw3MsAUNHkwWqZMq8hXPUuneSjETHOFSDLJU=
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
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, linux-hexagon@vger.kernel.org, X86 ML <x86@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Elvira Khabirova <lineprinter@altlinux.org>, arcml <linux-snps-arc@lists.infradead.org>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Andrew Lutomirski <luto@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Eric Paris <eparis@redhat.com>, linux-audit@redhat.com, linux-

On Tue, Nov 20, 2018 at 4:44 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>

Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
