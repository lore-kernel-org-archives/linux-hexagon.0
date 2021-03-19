From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC 2/3] mm: remove xlate_dev_kmem_ptr()
Date: Fri, 19 Mar 2021 15:54:29 +0100
Message-ID: <CAMuHMdVP433iVhyaweDd8G6p3ZCgSDq6M_ACko_BTgm+5m0qnA@mail.gmail.com>
References: <20210319143452.25948-1-david@redhat.com>
 <20210319143452.25948-3-david@redhat.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20210319143452.25948-3-david@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Hildenbrand <david@redhat.com>
Cc: Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Palmer Dabbelt <palmerdabbelt@google.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Linux MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@codeaurora.org>, Helge Deller <deller@gmx.de>

On Fri, Mar 19, 2021 at 3:36 PM David Hildenbrand <david@redhat.com> wrote:
> Since /dev/kmem has been removed, let's remove the xlate_dev_kmem_ptr()
> leftovers.

> Signed-off-by: David Hildenbrand <david@redhat.com>

>  arch/m68k/include/asm/io_mm.h   |  5 -----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
