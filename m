From: Guenter Roeck <linux@roeck-us.net>
Subject: Problems with 'Construct init thread stack in the linker script
 rather than by union' in -next
Date: Sat, 6 Jan 2018 14:45:23 -0800
Message-ID: <20180106224523.GA16811@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uScx2fYGlTnXH56RE1mTbpzs4HHS781Cz5EFR9dYlpQ=;
        b=YYEaSE0yAcC4TVxXbCrjQqKRmsJQZDqU6IZAiRab3ItJ/jlpIUdtbDZfZXypD1Nl/Y
         vjc9IHK23BuZEGMzAPsQ7NKtEWOgj/3IKe8obPldPKbnz5n77svWOHd1ew2qWTFyqYtn
         TPFj4qC9KqXo45z0naqyiGLSbYcaDZ6BsENwcsTsLE7W/oberplClfW60QYxTopWvVsr
         ELJNAw83aPNxZsS+aq6dUrdPZ0UaSRCavCp3+aOmMZQiy/75I159w+/bs8W6ka51BMhg
         Ih7Ht34QrXRjRvuKCxTgeRAj3Q53vxF/YGltpQIE3+wX22o5ILNIzMYpbdLPf0HyE0aH
         TGpQ==
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

Hi,

commit 7e7a20a2058dc ("Construct init thread stack in the linker script rather
than by union") results in various build failures in -next.

cris:

arch/cris/kernel/vmlinux.lds:67:
	undefined symbol `THREAD_SIZE' referenced in expression

crisv32:

arch/cris/kernel/vmlinux.lds:72:
	undefined symbol `THREAD_SIZE' referenced in expression

hexagon:

arch/hexagon/kernel/vmlinux.lds:41:
	undefined symbol `THREAD_SIZE' referenced in expression

openrisc:

arch/openrisc/kernel/vmlinux.lds:26:
	undefined symbol `THREAD_SIZE' referenced in expression

Bisect log (taken from cris) is attached.

Guenter

---
# bad: [990b6a07d18cb30a66db3d18ab7d953806237e6a] Add linux-next specific files for 20180105
# good: [30a7acd573899fd8b8ac39236eff6468b195ac7d] Linux 4.15-rc6
git bisect start 'HEAD' 'v4.15-rc6'
# good: [4411e1d8bfc93afafc74548669d772750432e0b7] Merge remote-tracking branch 'crypto/master'
git bisect good 4411e1d8bfc93afafc74548669d772750432e0b7
# good: [fcdad798ac60727fc0a90c36815d19b1629e45a4] Merge remote-tracking branch 'devicetree/for-next'
git bisect good fcdad798ac60727fc0a90c36815d19b1629e45a4
# good: [fe14c29e6d6772e5fc7bb8dc7a7568ce6a887a8e] Merge remote-tracking branch 'staging/staging-next'
git bisect good fe14c29e6d6772e5fc7bb8dc7a7568ce6a887a8e
# good: [b8be2479df7dda35d0d73fafa3f1d9c95c6a89b6] Merge remote-tracking branch 'gpio/for-next'
git bisect good b8be2479df7dda35d0d73fafa3f1d9c95c6a89b6
# good: [76248405844bf17c0620aea2f0e5bb751fc680b3] lib/stackdepot.c: use a non-instrumented version of memcmp()
git bisect good 76248405844bf17c0620aea2f0e5bb751fc680b3
# good: [37dc312d369803397a260bedea016670d9fc827a] Merge remote-tracking branch 'ntb/ntb-next'
git bisect good 37dc312d369803397a260bedea016670d9fc827a
# bad: [c2f271a55e60b1b25bab01a9e5de5097bd038ab5] Merge remote-tracking branch 'init_task/init_task'
git bisect bad c2f271a55e60b1b25bab01a9e5de5097bd038ab5
# good: [28e8fac00c1ccccc20fcde0573aef4318bd1e98c] ip: Define usercopy region in IP proto slab cache
git bisect good 28e8fac00c1ccccc20fcde0573aef4318bd1e98c
# good: [815cc87607f4b80e4d4449cc3355812af6bc6602] kvm: whitelist struct kvm_vcpu_arch
git bisect good 815cc87607f4b80e4d4449cc3355812af6bc6602
# bad: [3a0b110aa454910188f216d47247dc0d523fd2c9] Expand INIT_STRUCT_PID and remove
git bisect bad 3a0b110aa454910188f216d47247dc0d523fd2c9
# bad: [87732cfd2dfbcecdfb92ed13f238bb9ed8d6ea5f] Expand INIT_TASK() in init/init_task.c and remove
git bisect bad 87732cfd2dfbcecdfb92ed13f238bb9ed8d6ea5f
# bad: [7e7a20a2058dc8a5106593692cfb0876de028892] Construct init thread stack in the linker script rather than by union
git bisect bad 7e7a20a2058dc8a5106593692cfb0876de028892
# first bad commit: [7e7a20a2058dc8a5106593692cfb0876de028892] Construct init thread stack in the linker script rather than by union
