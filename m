From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3 00/50] Add log level to show_stack()
Date: Sun, 19 Apr 2020 08:24:59 +0200
Message-ID: <510426be-c95f-adea-af6a-51e592f41ce0@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587277511;
 bh=R0GHJO7eG/0xS8Mj3Xwo95YcotDuEUImghkPfpCjkFc=;
 h=X-UI-Sender-Class:To:Subject:From:Cc:Date;
 b=Xh1rc4a2nTe2FRbuM2d3LFUpy2ATvwL6Mq2jASXH2Uj1VECi3BtaU5jTeDU96zUi+
 gwYzUq+VcXKoRGDrodiVHQrXb1tznMtvGdEFxr0epor8v8528Eupg9FhX4N5yizX0i
 J6tVmFc1f+jyCb7V0IZQSHGzySHfodHG+S60VHtQ=
Content-Language: en-GB
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="utf-8"
To: Dmitry Safonov <dima@arista.com>, clang-built-linux@googlegroups.com, kgdb-bugreport@lists.sourceforge.net, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Petr Mladek <pmladek@suse.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Paul Mackerras <paulus@samba.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, Daniel Thompson <daniel.thompson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Helge Deller <del>

> Changes to v3:
> - Collected more architectual Acks and Reviewed-by

* I suggest to avoid a typo in this description.

* Please separate the tag =E2=80=9CPATCH=E2=80=9D from the version descrip=
tor in the subject.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D50cc09c18985eacbbd666acf=
d7be2391394733f5#n709

Regards,
Markus
