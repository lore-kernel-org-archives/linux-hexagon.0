From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/14] uaccess: remove most CONFIG_SET_FS users
Date: Mon, 14 Feb 2022 09:06:04 -0800
Message-ID: <YgqL/NJ3YHEAhj4i@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-11-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t8DJ+yUxfFt/OTlQTgnOgIhpd5JCYBJKeayq9xpZvvk=; b=Jd6yJJiObJ9HpV
	765lO11dVCbo5VfjPqtmD8mWiuYA6UlVttOLhcDB9asU6Uvuj9bufYbofLKmmQDIPmjB9nZvvNsJk
	HQIqEfClaWA5YfFvIckgrAOMMMawbRzDUMKbKI6/+RwoSVgCMy3zou852vtOEtffUCJtpc3TTineZ
	6GKPk62OE34V55IZjKkXz6vMp5NQ2R5Qb5ptsk69j4qwvnnjRYMVyW6cGYCA6j+SIxMuknHNUIpQ+
	sgTkYBP98zyatm7wY5sONxmTjZls2UEMArG3Y3hiVtwQqaDaHF4X7MCCG72Ah6gmCfRDYI7rXeLPJ
	N0PDYBIQCy0hhqmspRJQ==;
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-11-arnd@kernel.org>
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
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, mark.rutland@arm.com, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, jcmvbkbc@gmail.com, guoren@kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, will@kernel.org, ardb@kernel.org, linux-s390@vger.kernel.org, bcain@codeaurora.org, deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@redhat.com, geert@linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, hca@linux.ibm.com, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, green.hu@gmail.com, s

On Mon, Feb 14, 2022 at 05:34:48PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On almost all architectures, there are no remaining callers
> of set_fs(), so CONFIG_SET_FS can be disabled, along with
> removing the thread_info field and any references to it.
> 
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.

Wouldn't it make more sense to just merge this into the last patch?
