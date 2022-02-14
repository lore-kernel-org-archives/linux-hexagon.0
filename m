From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 10/14] uaccess: remove most CONFIG_SET_FS users
Date: Mon, 14 Feb 2022 20:40:07 +0100
Message-ID: <CAK8P3a3eOw=QpxWFnODE61EFt8oGPJ7dcusfbPSD1vdEsUmekQ@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-11-arnd@kernel.org>
 <YgqL/NJ3YHEAhj4i@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QGCdvMLs+y5szyo9mkpTXLks177+98b7gN0+EvDOXp0=; b=cjXsaJb51Ex7Uz
	1vOSSTSyvHkeR7boVRzRTJ6ToXnV24SURGAUWNFYzH7gDj7Z9eSJvXpZ+Y6wLt8a43InA42y6F0bo
	USSNGLHwiC9rAqJY36FSUTZlaw29c7sv24n/W4Qrm2Mz1VseqYBWlIcY11rHLczyCJPBSq4rBepQ6
	1lLz9sNp7Yc4BgcuZTU+t6ZsMh5vDj3owY6TP/QruLWz1jKDS+YP8H1W14nSz5Gb0d+ZwV7OHMtf/
	cJmBo+pZcw3tb7oMmh6zxaPwPsNfAXs7P62HmTAt5K0GtlS+vB2wEl5cVmCWr++NI2lBdVHvZdckC
	sPAW0bfh74keI5CWDx6A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644867624;
 bh=5szbHF9etsKpvbwWwwc9H/Y1QakuvzjKYGUIBcYFA80=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=e8SkA3FlLGu70hI/WgHcE1Xcld6ahEqgd/8aP3tnN+Ui+6c+MZmJxArGum1LdtmAc
 TVm8LqkWXJbpel0WqJluZlN0q2Rc8pObOFXCjWsE1d3haVSN1sOjQ5hKRVHWsZ71lN
 9Hnj9zqBHSBBx6qUNlA6sc7rmD8pMbOGHJ9SDDCXuRY9FNQ7binWt4bsfA/Yof8Egb
 Ksm8rfkNmn9T9/rsBeFI1yBap4xnb6nVmSKUusmotl5Q02Llm+mwF8WcKWget2RALt
 X3B6AavEfyIeX6XUTomqUIV78jVQAYplU/28sKTs9My6dabsF705ywSdaO+p8h0D4l
 JZS2fHyItMkuQ==
In-Reply-To: <YgqL/NJ3YHEAhj4i@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers

On Mon, Feb 14, 2022 at 6:06 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:48PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > On almost all architectures, there are no remaining callers
> > of set_fs(), so CONFIG_SET_FS can be disabled, along with
> > removing the thread_info field and any references to it.
> >
> > This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
>
> Wouldn't it make more sense to just merge this into the last patch?

Yes, sounds good. I wasn't sure at first if there is enough buy-in to get
all architectures cleaned up, and I hadn't done the ia64 patch, so it
seemed more important to do this part early, but now it seems that it
will all go in at the same time, so doing this as part of a big removal
at the end makes sense.

        Arnd
