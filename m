From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 27/31] exec: only build read_code when needed
Date: Sun, 10 May 2020 09:55:06 +0200
Message-ID: <20200510075510.987823-28-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oCdrIxNzR4NHS2NDYxpGK2EFu2WHsVdB0VGTwPSxhuk=; b=Q+7UfgQ3Rdq+rLentMN2OrWKT3
        jTnHLTbJ6Yo8QYhjLeB8vp2MreobznJtTFQ0jlaiUn5RGr0TWosPvI6rcQTJE/Et+fDYfoHslzFqw
        /BWbCS4JJSasi/72B4NdftCFoYId60ALrCeqbqSFqlmZALTsuQbRcxZdE7gVEMRUZ+2jJgbwFOeTc
        q0RSZogxgE3wUwtPbM4tnpRSA/1iH3V8P+QeyF82EweD60S2UCkj7Bj8IUJ6rB3V0/NRIyG7Xj/d5
        ro+hoo6ZZWAwhBD9nnrcR3crM1Fw3XFyChwrI8FcD9H77DOo0SD2ywb9vJJFHT9ycuVP7MGMEc0Zc
        hBawSvig==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

Only build read_code when binary formats that use it are built into the
kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d9..a4f766f296f8f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1027,6 +1027,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
+#if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
+    defined(CONFIG_BINFMT_ELF_FDPIC)
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
@@ -1035,6 +1037,7 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 	return res;
 }
 EXPORT_SYMBOL(read_code);
+#endif
 
 /*
  * Maps the mm_struct mm into the current task struct.
-- 
2.26.2

