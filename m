From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] arch: remove redundant generic-y defines
Date: Wed, 5 Dec 2018 06:45:17 -0800
Message-ID: <20181205144517.GB30692@infradead.org>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
 <1544009286-15705-3-git-send-email-yamada.masahiro@socionext.com>
 <20181205144438.GA30692@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PbgxQH1K0/A+5v90e6bwoErht5/X2IRNyyt2y3mbPkI=; b=acY0GlIDIEHWkB
	l/7owmCo8RFlLOneQKvGJRXC7y4r94Kv3svHede19tp3FsQtlHlmjGF3VpFfQtxtD/D1Fp2rNk11P
	9AEmvhVP2+v+FgbqGj9KutrlO27C8eYDlAScBzwW8jwAD795j+bpClxqr0E613w5JMPe2QHcO3LuV
	PlgXSGN0k1HHLYdiJD+LiJUpwa7j0v4t9Y3Wl5IEcunTCaCOChEz6ApKCZitKilBjWdoXeW+JaPdk
	S4AYVjT7LnAIhQv41yYNsKCAIUmMnIwoERvV6auYJNPEZ9B/GBiao3IO6Vb9feovAZyDChKkR/ck4
	7ZRi/pxh+bRgR9L61XcA==;
Content-Disposition: inline
In-Reply-To: <20181205144438.GA30692@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, James Hogan <jhogan@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Russell King <linux@armlinux.org.uk>, Max Filippov <jcmvbkbc@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Stafford Horne <shorne@gmail.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Daniel Borkmann <daniel@iogearbox.net>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, James E.J. Bottomley

On Wed, Dec 05, 2018 at 06:44:38AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 05, 2018 at 08:28:06PM +0900, Masahiro Yamada wrote:
> > Now that Kbuild automatically creates asm-generic wrappers for missing
> > mandatory headers, it is redundant to list the same headers in
> > generic-y and mandatory-y.
> > 
> > Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> Oh, that is very useful, especially as maintainance of those
> generic-y lines has been a mess!
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

Actually - it seems like you are keeping some generic-y lines, what
is the reason for that?
