Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD9393A6794
	for <lists+kvmarm@lfdr.de>; Mon, 14 Jun 2021 15:19:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 53E9F4B0B2;
	Mon, 14 Jun 2021 09:19:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J9sx7frRyxP4; Mon, 14 Jun 2021 09:19:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ACAFA4B08A;
	Mon, 14 Jun 2021 09:19:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 271BE4B07F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Jun 2021 09:19:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q-XoOFSW3R0U for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Jun 2021 09:19:16 -0400 (EDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 671194A2E5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Jun 2021 09:19:16 -0400 (EDT)
Received: by mail-lj1-f172.google.com with SMTP id 131so20179700ljj.3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Jun 2021 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SlrMZ4dwNYn/ZEK4g9WD4YfB6VDpQni4QzxQiKRf/5Q=;
 b=gh7ZHmgp265oLvqqvEuLJMVmvQevoPFQYJEVz2YVfV5rF6AdX2tw6jbNEyS9oqKRSf
 DAx+vZXJhN/8jPsH/6U6X1SHanCm+jfDrIeBc1o8E8aQQQSxVmU2xY3GPqZE4mmxuReZ
 yoL53V/auJl3zr/qpV3vTIW1ZlJtBIo6klS3ENQmrCRyzcZ7DgtdViGDKol1+CCpGt5v
 +QzHDIswq8gySkr9V0UTt8mJQGebnGJoBv6QtLSL310Z1WgMp4TVwXluXh+BImTXkE9r
 a0esStXpOWg89hsIjzwLBFORuqbw9IbHNItbUfapkBY22xJK4iU0NZHsjoPgyf6WoLEG
 4kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SlrMZ4dwNYn/ZEK4g9WD4YfB6VDpQni4QzxQiKRf/5Q=;
 b=POdKGSiZTbUHGFaPaThazWkych0yPhZdoE+X870DTJ60YiU3c9hkW0iqxZQYhduwAN
 /e2g8xeNqUinT6yj9oVtqnCMJR4HpAaCFTmzx4TPgyfWdpFSt9NiwFjRXsR8L9IfSzde
 g23akIVo6Y4fAdxdkEDcwZJfdZIZEXehkLFuyw3jyRO69A6+NNLwtLESDL5G6Bw7qLsH
 6fZmqKLmdMT0PkjlL1NWqNnh+PiG/VAPYUzjp9Qn8oRCn87PyYDjSR7TlvdMycvF/a16
 HeYxoXYVXYVCDIGf3s1hbzH12c0nLogRtFO+Qg5Mo/N183ouNzlmAF9eHZAVz5pTLGEB
 MeEw==
X-Gm-Message-State: AOAM532Paav+yGnp2DGu6f+Su2VSb+IsrRNJrDz0br+T2Di30C+S2OwC
 nTCKHi/KXXmzIYr7dwgGOE4m2ovuQPAyYKriAcml8g==
X-Google-Smtp-Source: ABdhPJxLFgBwZYSWOFz+YE4WYc05v7MCMMRXGHJiA9VktBcIbsNdxJoFsu9oGwcnR++LD4Yxu0mR/mu0bpUhJ9OAcdA=
X-Received: by 2002:a05:651c:d7:: with SMTP id
 23mr13784560ljr.207.1623676754764; 
 Mon, 14 Jun 2021 06:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-4-jingzhangos@google.com>
 <CA+EHjTxeZOAPA9w6UJe7rW+-UdznrEsNmomWodZDN3DLgLoJKA@mail.gmail.com>
In-Reply-To: <CA+EHjTxeZOAPA9w6UJe7rW+-UdznrEsNmomWodZDN3DLgLoJKA@mail.gmail.com>
From: Jing Zhang <jingzhangos@google.com>
Date: Mon, 14 Jun 2021 08:19:02 -0500
Message-ID: <CAAdAUtiVcUqix3W7YZ5HU6VjWwkZEsgWFJ=4S2xeyWHLn8Q5zA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] KVM: stats: Add documentation for statistics data
 binary interface
To: Fuad Tabba <tabba@google.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>,
 David Matlack <dmatlack@google.com>, Jim Mattson <jmattson@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Shier <pshier@google.com>, LinuxMIPS <linux-mips@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Fuad,

On Mon, Jun 14, 2021 at 2:57 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Jing,
>
>
> On Thu, Jun 3, 2021 at 10:14 PM Jing Zhang <jingzhangos@google.com> wrote:
> >
> > Update KVM API documentation for binary statistics.
> >
> > Reviewed-by: David Matlack <dmatlack@google.com>
> > Reviewed-by: Ricardo Koller <ricarkol@google.com>
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 180 +++++++++++++++++++++++++++++++++
> >  1 file changed, 180 insertions(+)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 7fcb2fd38f42..550bfbdf611b 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -5034,6 +5034,178 @@ see KVM_XEN_VCPU_SET_ATTR above.
> >  The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
> >  with the KVM_XEN_VCPU_GET_ATTR ioctl.
> >
> > +4.130 KVM_GET_STATS_FD
> > +---------------------
>
> nit: missing one - (to match the subtitle length)
>
> > +
> > +:Capability: KVM_CAP_STATS_BINARY_FD
> > +:Architectures: all
> > +:Type: vm ioctl, vcpu ioctl
> > +:Parameters: none
> > +:Returns: statistics file descriptor on success, < 0 on error
> > +
> > +Errors:
> > +
> > +  ======     ======================================================
> > +  ENOMEM     if the fd could not be created due to lack of memory
> > +  EMFILE     if the number of opened files exceeds the limit
> > +  ======     ======================================================
> > +
> > +The file descriptor can be used to read VM/vCPU statistics data in binary
> > +format. The file data is organized into three blocks as below:
> > ++-------------+
> > +|   Header    |
> > ++-------------+
> > +| Descriptors |
> > ++-------------+
> > +| Stats Data  |
> > ++-------------+
> > +
> > +The Header block is always at the start of the file. It is only needed to be
> > +read one time for the lifetime of the file descriptor.
> > +It is in the form of ``struct kvm_stats_header`` as below::
> > +
> > +       #define KVM_STATS_ID_MAXLEN             64
> > +
> > +       struct kvm_stats_header {
> > +               char id[KVM_STATS_ID_MAXLEN];
> > +               __u32 name_size;
> > +               __u32 count;
> > +               __u32 desc_offset;
> > +               __u32 data_offset;
> > +       };
> > +
> > +The ``id`` field is identification for the corresponding KVM statistics. For
> > +VM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345". For
> > +VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", like
> > +"kvm-12345/vcpu-12".
> > +
> > +The ``name_size`` field is the size (byte) of the statistics name string
> > +(including trailing '\0') appended to the end of every statistics descriptor.
> > +
> > +The ``count`` field is the number of statistics.
> > +
> > +The ``desc_offset`` field is the offset of the Descriptors block from the start
> > +of the file indicated by the file descriptor.
> > +
> > +The ``data_offset`` field is the offset of the Stats Data block from the start
> > +of the file indicated by the file descriptor.
> > +
> > +The Descriptors block is only needed to be read once for the lifetime of the
> > +file descriptor. It is an array of ``struct kvm_stats_desc`` as shown in
> > +below code block::
> > +
> > +       #define KVM_STATS_TYPE_SHIFT            0
> > +       #define KVM_STATS_TYPE_MASK             (0xF << KVM_STATS_TYPE_SHIFT)
> > +       #define KVM_STATS_TYPE_CUMULATIVE       (0x0 << KVM_STATS_TYPE_SHIFT)
> > +       #define KVM_STATS_TYPE_INSTANT          (0x1 << KVM_STATS_TYPE_SHIFT)
> > +       #define KVM_STATS_TYPE_MAX              KVM_STATS_TYPE_INSTANT
> > +
> > +       #define KVM_STATS_UNIT_SHIFT            4
> > +       #define KVM_STATS_UNIT_MASK             (0xF << KVM_STATS_UNIT_SHIFT)
> > +       #define KVM_STATS_UNIT_NONE             (0x0 << KVM_STATS_UNIT_SHIFT)
> > +       #define KVM_STATS_UNIT_BYTES            (0x1 << KVM_STATS_UNIT_SHIFT)
> > +       #define KVM_STATS_UNIT_SECONDS          (0x2 << KVM_STATS_UNIT_SHIFT)
> > +       #define KVM_STATS_UNIT_CYCLES           (0x3 << KVM_STATS_UNIT_SHIFT)
> > +       #define KVM_STATS_UNIT_MAX              KVM_STATS_UNIT_CYCLES
> > +
> > +       #define KVM_STATS_BASE_SHIFT            8
> > +       #define KVM_STATS_BASE_MASK             (0xF << KVM_STATS_BASE_SHIFT)
> > +       #define KVM_STATS_BASE_POW10            (0x0 << KVM_STATS_BASE_SHIFT)
> > +       #define KVM_STATS_BASE_POW2             (0x1 << KVM_STATS_BASE_SHIFT)
> > +       #define KVM_STATS_BASE_MAX              KVM_STATS_BASE_POW2
> > +
> > +       struct kvm_stats_desc {
> > +               __u32 flags;
> > +               __s16 exponent;
> > +               __u16 size;
> > +               __u32 unused1;
> > +               __u32 unused2;
> > +               char name[0];
> > +       };
> > +
> > +The ``flags`` field contains the type and unit of the statistics data described
> > +by this descriptor. The following flags are supported:
> > +
> > +Bits 0-3 of ``flags`` encode the type:
> > +  * ``KVM_STATS_TYPE_CUMULATIVE``
> > +    The statistics data is cumulative. The value of data can only be increased.
> > +    Most of the counters used in KVM are of this type.
> > +    The corresponding ``count`` filed for this type is always 1.
>
> filed -> field
>
> > +  * ``KVM_STATS_TYPE_INSTANT``
> > +    The statistics data is instantaneous. Its value can be increased or
> > +    decreased. This type is usually used as a measurement of some resources,
> > +    like the number of dirty pages, the number of large pages, etc.
> > +    The corresponding ``count`` field for this type is always 1.
> > +
> > +Bits 4-7 of ``flags`` encode the unit:
> > +  * ``KVM_STATS_UNIT_NONE``
> > +    There is no unit for the value of statistics data. This usually means that
> > +    the value is a simple counter of an event.
> > +  * ``KVM_STATS_UNIT_BYTES``
> > +    It indicates that the statistics data is used to measure memory size, in the
> > +    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
> > +    determined by the ``exponent`` field in the descriptor. The
> > +    ``KVM_STATS_BASE_POW2`` flag is valid in this case. The unit of the data is
> > +    determined by ``pow(2, exponent)``. For example, if value is 10,
> > +    ``exponent`` is 20, which means the unit of statistics data is MiByte, we
> > +    can get the statistics data in the unit of Byte by
> > +    ``value * pow(2, exponent) = 10 * pow(2, 20) = 10 MiByte`` which is
> > +    10 * 1024 * 1024 Bytes.
> > +  * ``KVM_STATS_UNIT_SECONDS``
> > +    It indicates that the statistics data is used to measure time/latency, in
> > +    the unit of nanosecond, microsecond, millisecond and second. The unit of the
> > +    data is determined by the ``exponent`` field in the descriptor. The
> > +    ``KVM_STATS_BASE_POW10`` flag is valid in this case. The unit of the data
> > +    is determined by ``pow(10, exponent)``. For example, if value is 2000000,
> > +    ``exponent`` is -6, which means the unit of statistics data is microsecond,
> > +    we can get the statistics data in the unit of second by
> > +    ``value * pow(10, exponent) = 2000000 * pow(10, -6) = 2 seconds``.
> > +  * ``KVM_STATS_UNIT_CYCLES``
> > +    It indicates that the statistics data is used to measure CPU clock cycles.
> > +    The ``KVM_STATS_BASE_POW10`` flag is valid in this case. For example, if
> > +    value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
> > +    by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
> > +
> > +Bits 7-11 of ``flags`` encode the base:
>
> Bits 8-11
>
> > +  * ``KVM_STATS_BASE_POW10``
> > +    The scale is based on power of 10. It is used for measurement of time and
> > +    CPU clock cycles.
> > +  * ``KVM_STATS_BASE_POW2``
> > +    The scale is based on power of 2. It is used for measurement of memory size.
> > +
> > +The ``exponent`` field is the scale of corresponding statistics data. For
> > +example, if the unit is ``KVM_STATS_UNIT_BYTES``, the base is
> > +``KVM_STATS_BASE_POW2``, the ``exponent`` is 10, then we know that the real
> > +unit of the statistics data is KBytes a.k.a pow(2, 10) = 1024 bytes.
> > +
> > +The ``size`` field is the number of values of this statistics data. It is in the
> > +unit of ``unsigned long`` for VM or ``__u64`` for VCPU.
> > +
> > +The ``unused1`` and ``unused2`` fields are reserved for future
> > +support for other types of statistics data, like log/linear histogram.
> > +
> > +The ``name`` field points to the name string of the statistics data. The name
> > +string starts at the end of ``struct kvm_stats_desc``.
> > +The maximum length (including trailing '\0') is indicated by ``name_size``
> > +in ``struct kvm_stats_header``.
> > +
> > +The Stats Data block contains an array of data values of type ``struct
> > +kvm_vm_stats_data`` or ``struct kvm_vcpu_stats_data``. It would be read by
> > +user space periodically to pull statistics data.
> > +The order of data value in Stats Data block is the same as the order of
> > +descriptors in Descriptors block.
> > +  * Statistics data for VM::
> > +
> > +       struct kvm_vm_stats_data {
> > +               unsigned long value[0];
> > +       };
> > +
> > +  * Statistics data for VCPU::
> > +
> > +       struct kvm_vcpu_stats_data {
> > +               __u64 value[0];
> > +       };
> > +
> >  5. The kvm_run structure
> >  ========================
> >
> > @@ -6891,3 +7063,11 @@ This capability is always enabled.
> >  This capability indicates that the KVM virtual PTP service is
> >  supported in the host. A VMM can check whether the service is
> >  available to the guest on migration.
> > +
> > +8.33 KVM_CAP_STATS_BINARY_FD
> > +----------------------------
> > +
> > +:Architectures: all
> > +
> > +This capability indicates the feature that user space can create get a file
> > +descriptor for every VM and VCPU to read statistics data in binary format.
>
> nit: user space -> userspace (it's spelled that way throughout this document)
>
> Cheers,
> /fuad
>
> > --
> > 2.32.0.rc1.229.g3e70b5a671-goog
> >
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm@lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
Thanks for the review!
Jing
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
