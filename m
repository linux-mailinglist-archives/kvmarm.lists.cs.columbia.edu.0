Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBB3897EB
	for <lists+kvmarm@lfdr.de>; Wed, 19 May 2021 22:30:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 840754B8B9;
	Wed, 19 May 2021 16:30:47 -0400 (EDT)
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
	with ESMTP id BxTFILISJmP9; Wed, 19 May 2021 16:30:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D47CD4B898;
	Wed, 19 May 2021 16:30:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E9264B45E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 16:30:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N5KBQ7eSyHIv for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 May 2021 16:30:42 -0400 (EDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AB8D04B45B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 16:30:42 -0400 (EDT)
Received: by mail-lf1-f45.google.com with SMTP id x19so21077969lfa.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o8p6x5gyMA7Cq4Y2sm3AZ6wHEeXX/eUZuwdkIhXGxFo=;
 b=E0pHFtVzg6XQZsm22E2NXJq4R9G47r6YNbq2xSMv68Iq3fxs3QP0ceZYxIxWevV/nm
 CVtKsvNK4jlbdFX/ZPbziXNQdeHXo6AG8tAbOrq5VLnje9+J2ZtBAJ38qd67w/5gXcT7
 xhx4RIgoFR493HYfbcohf7IsIIqTPM4FXiFkXXO473Ye8wYPX1iqjvDpxE7M1oBfrRT9
 ic0Gf4XMMIq2eqQ82OQmH88nU0L0jdXl7IF5lG3DChKoX9B/h5tk0vnHqE8cwcpuDGDC
 YuqO/mNft2hCjmDL8krBKJQIR0GCoD2j5glZFv5T2VlHkvX4JLXC69y6XyrCrt8P9qjp
 aV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o8p6x5gyMA7Cq4Y2sm3AZ6wHEeXX/eUZuwdkIhXGxFo=;
 b=PVSHO6P+f7k4MBgV0iN3R0Lv1RzwplQGEaI9JfOc6lDTHo7L32QBiVW1AGJJCCif5q
 Fgz4H8/Lnv36YWrWBzrUUVCROCLBUstsp8f7LLtogg30H2Zy35hR5Cfnasq1jH0Lxj8s
 1b2LgRp9R7YmRPQIwJ9MpWFn7R0To67FjXjvSZNYyIKUSHom81bnYf2anaeLV20E/X5c
 xiZcZ7H173QCdR6GYfg3nYUjGbknwRFBZzhrGt8Ismwxi8YSX0PbX00oIg9EM+jcHxRa
 j9ZClomCdFbSM4loq9KHylklFYrPUC39PzdiyX/OMLONF0cAsuLc/eEvJvmtPUpN/mht
 RcKw==
X-Gm-Message-State: AOAM533/pZQfY1n+BhWjkOV3oE+STqJnmt+MGE8K1MIPjc13X2pjvVyE
 MuatoVHpSv+w91CcewLBK8F/wll2kyysGzxQufC3jA==
X-Google-Smtp-Source: ABdhPJwZhBCxRDMJVZIu6f5xg2ImeRxx1cn1Mg8Cx2otHoyb5uM1PjycpK4mOj/unDmxFzbnG8qU5S4opSvvs1jm9a8=
X-Received: by 2002:a05:6512:3a4:: with SMTP id
 v4mr880544lfp.473.1621456240928; 
 Wed, 19 May 2021 13:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-4-jingzhangos@google.com>
 <CALzav=e9iLLzZyccXq6gTM0nv6n=6qEUO+VYQ-RzJ44tNK30NQ@mail.gmail.com>
 <CAAdAUti+XkyJBYsJQjXMdENTyMgzhNxFyLKacBmTT2KW4MQigw@mail.gmail.com>
In-Reply-To: <CAAdAUti+XkyJBYsJQjXMdENTyMgzhNxFyLKacBmTT2KW4MQigw@mail.gmail.com>
From: Jing Zhang <jingzhangos@google.com>
Date: Wed, 19 May 2021 15:30:28 -0500
Message-ID: <CAAdAUtiuQCoCmhqGYYF8DfPBDJ943oBuL_2BTdga074R70b-5w@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] KVM: stats: Add documentation for statistics data
 binary interface
To: David Matlack <dmatlack@google.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Jim Mattson <jmattson@google.com>,
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

On Wed, May 19, 2021 at 2:29 PM Jing Zhang <jingzhangos@google.com> wrote:
>
> Hi David,
>
> On Wed, May 19, 2021 at 11:57 AM David Matlack <dmatlack@google.com> wrote:
> >
> > On Mon, May 17, 2021 at 9:25 AM Jing Zhang <jingzhangos@google.com> wrote:
> > >
> > > Update KVM API documentation for binary statistics.
> > >
> > > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > > ---
> > >  Documentation/virt/kvm/api.rst | 171 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 171 insertions(+)
> > >
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > > index 7fcb2fd38f42..9a6aa9770dfd 100644
> > > --- a/Documentation/virt/kvm/api.rst
> > > +++ b/Documentation/virt/kvm/api.rst
> > > @@ -5034,6 +5034,169 @@ see KVM_XEN_VCPU_SET_ATTR above.
> > >  The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
> > >  with the KVM_XEN_VCPU_GET_ATTR ioctl.
> > >
> > > +4.130 KVM_STATS_GETFD
> > > +---------------------
> > > +
> > > +:Capability: KVM_CAP_STATS_BINARY_FD
> > > +:Architectures: all
> > > +:Type: vm ioctl, vcpu ioctl
> > > +:Parameters: none
> > > +:Returns: statistics file descriptor on success, < 0 on error
> > > +
> > > +Errors:
> > > +
> > > +  ======     ======================================================
> > > +  ENOMEM     if the fd could not be created due to lack of memory
> > > +  EMFILE     if the number of opened files exceeds the limit
> > > +  ======     ======================================================
> > > +
> > > +The file descriptor can be used to read VM/vCPU statistics data in binary
> > > +format. The file data is organized into three blocks as below:
> > > ++-------------+
> > > +|   Header    |
> > > ++-------------+
> > > +| Descriptors |
> > > ++-------------+
> > > +| Stats Data  |
> > > ++-------------+
> > > +
> > > +The Header block is always at the start of the file. It is only needed to be
> > > +read one time after a system boot.
> >
> > By system boot do you mean the host or the VM? If the host then it's
> > probably just cleaner to omit that part entirely and just say "It is
> > only needed to be read once.".
> >
> Will change "system boot" to "VM boot".
> > > +It is in the form of ``struct kvm_stats_header`` as below::
> > > +
> > > +       #define KVM_STATS_ID_MAXLEN             64
> > > +
> > > +       struct kvm_stats_header {
> > > +               char id[KVM_STATS_ID_MAXLEN];
> > > +               __u32 name_size;
> > > +               __u32 count;
> > > +               __u32 desc_offset;
> > > +               __u32 data_offset;
> > > +       };
> > > +
> > > +The ``id`` field is identification for the corresponding KVM statistics. For
> > > +KVM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345". For
> >
> > Should this say "For VM statistics, ..." instead?
> >
> Yes, will fix it.
> > > +VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", like
> > > +"kvm-12345/vcpu-12".
> > > +
> > > +The ``name_size`` field is the size (byte) of the statistics name string
> > > +(including trailing '\0') appended to the end of every statistics descriptor.
> > > +
> > > +The ``count`` field is the number of statistics.
> > > +
> > > +The ``desc_offset`` field is the offset of the Descriptors block from the start
> > > +of the file indicated by the file descriptor.
> > > +
> > > +The ``data_offset`` field is the offset of the Stats Data block from the start
> > > +of the file indicated by the file descriptor.
> > > +
> > > +The Descriptors block is only needed to be read once after a system boot. It is
> >
> > Ditto here about system boot.
> >
> > > +an array of ``struct kvm_stats_desc`` as below::
> >
> > Consider omitting these macros from the documentation, or moving them
> > to later. Readers right here are expecting to see the struct
> > kvm_stats_desc given the previous line.
> >
> How about changing "as below" to "as shown in below code block"?
> > > +
> > > +       #define KVM_STATS_TYPE_SHIFT            0
> > > +       #define KVM_STATS_TYPE_MASK             (0xF << KVM_STATS_TYPE_SHIFT)
> > > +       #define KVM_STATS_TYPE_CUMULATIVE       (0x0 << KVM_STATS_TYPE_SHIFT)
> > > +       #define KVM_STATS_TYPE_INSTANT          (0x1 << KVM_STATS_TYPE_SHIFT)
> > > +       #define KVM_STATS_TYPE_MAX              KVM_STATS_TYPE_INSTANT
> > > +
> > > +       #define KVM_STATS_UNIT_SHIFT            4
> > > +       #define KVM_STATS_UNIT_MASK             (0xF << KVM_STATS_UNIT_SHIFT)
> > > +       #define KVM_STATS_UNIT_NONE             (0x0 << KVM_STATS_UNIT_SHIFT)
> > > +       #define KVM_STATS_UNIT_BYTES            (0x1 << KVM_STATS_UNIT_SHIFT)
> > > +       #define KVM_STATS_UNIT_SECONDS          (0x2 << KVM_STATS_UNIT_SHIFT)
> > > +       #define KVM_STATS_UNIT_CYCLES           (0x3 << KVM_STATS_UNIT_SHIFT)
> > > +       #define KVM_STATS_UNIT_MAX              KVM_STATS_UNIT_CYCLES
> > > +
> > > +       #define KVM_STATS_SCALE_SHIFT           8
> > > +       #define KVM_STATS_SCALE_MASK            (0xF << KVM_STATS_SCALE_SHIFT)
> > > +       #define KVM_STATS_SCALE_POW10           (0x0 << KVM_STATS_SCALE_SHIFT)
> > > +       #define KVM_STATS_SCALE_POW2            (0x1 << KVM_STATS_SCALE_SHIFT)
> > > +       #define KVM_STATS_SCALE_MAX             KVM_STATS_SCALE_POW2
> >
> > Terminology nit: I think usually this part is called the "base". e.g.
> > when you decompose a number X into N * B^E, B is the "base" and E is
> > the "exponent". I see you're using "exponent" already but it might
> > make sense to change "scale" to "base" throughout this series.
> >
> Will change "SCALE" to "SCALE_BASE".
> > > +
> > > +       struct kvm_stats_desc {
> > > +               __u32 flags;
> > > +               __s16 exponent;
> > > +               __u16 size;
> > > +               __u32 unused1;
> > > +               __u32 unused2;
> > > +               char name[0];
> > > +       };
> > > +
> > > +The ``flags`` field contains the type and unit of the statistics data described
> > > +by this descriptor. The following flags are supported:
> >
> > nit: Suggest breaking this list out into separate lists so readers can
> > differentiate between the type, unit, and scale. Something like:
> >
> > Bits 0-3 of ``flags`` encode the type:
> >
> > * ``KVM_STATS_TYPE_CUMULATIVE`` ...
> > * ``KVM_STATS_TYPE_INSTANT`` ...
> >
> > Bits 4-7 of ``flags encode the unit:
> >
> > * ``KVM_STATS_UNIT_NONE`` ...
> > ...
> > etc.
> >
> Good suggestion. Will do that.
> > > +  * ``KVM_STATS_TYPE_CUMULATIVE``
> > > +    The statistics data is cumulative. The value of data can only be increased.
> > > +    Most of the counters used in KVM are of this type.
> > > +    The corresponding ``count`` filed for this type is always 1.
> > > +  * ``KVM_STATS_TYPE_INSTANT``
> > > +    The statistics data is instantaneous. Its value can be increased or
> > > +    decreased. This type is usually used as a measurement of some resources,
> > > +    like the number of dirty pages, the number of large pages, etc.
> > > +    The corresponding ``count`` field for this type is always 1.
> > > +  * ``KVM_STATS_UNIT_NONE``
> > > +    There is no unit for the value of statistics data. This usually means that
> > > +    the value is a simple counter of an event.
> > > +  * ``KVM_STATS_UNIT_BYTES``
> > > +    It indicates that the statistics data is used to measure memory size, in the
> > > +    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
> > > +    determined by the ``exponent`` field in the descriptor. The
> > > +    ``KVM_STATS_SCALE_POW2`` flag is valid in this case. The unit of the data is
> > > +    determined by ``pow(2, exponent)``. For example, if value is 10,
> > > +    ``exponent`` is 20, which means the unit of statistics data is MiByte, we
> > > +    can get the statistics data in the unit of Byte by
> > > +    ``value * pow(2, exponent) = 10 * pow(2, 20) = 10 MiByte`` which is
> > > +    10 * 1024 * 1024 Bytes.
> > > +  * ``KVM_STATS_UNIT_SECONDS``
> > > +    It indicates that the statistics data is used to measure time/latency, in
> > > +    the unit of nanosecond, microsecond, millisecond and second. The unit of the
> > > +    data is determined by the ``exponent`` field in the descriptor. The
> > > +    ``KVM_STATS_SCALE_POW10`` flag is valid in this case. The unit of the data
> > > +    is determined by ``pow(10, exponent)``. For example, if value is 2000000,
> > > +    ``exponent`` is -6, which means the unit of statistics data is microsecond,
> > > +    we can get the statistics data in the unit of second by
> > > +    ``value * pow(10, exponent) = 2000000 * pow(10, -6) = 2 seconds``.
> > > +  * ``KVM_STATS_UNIT_CYCLES``
> > > +    It indicates that the statistics data is used to measure CPU clock cycles.
> > > +    The ``KVM_STATS_SCALE_POW10`` flag is valid in this case. For example, if
> > > +    value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
> > > +    by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
> > > +
> > > +The ``exponent`` field is the scale of corresponding statistics data. It has two
> > > +values as follows:
> > > +  * ``KVM_STATS_SCALE_POW10``
> >
> > I thought the scale was encoded in ``flags`` not ``exponent``? Isn't
> > the exponent the
> >
> The base is encoded in ``flags``, not the exponent.
The description about ``exponent`` is not right here. Will fix it.
> > > +    The scale is based on power of 10. It is used for measurement of time and
> > > +    CPU clock cycles.
> > > +  * ``KVM_STATS_SCALE_POW2``
> > > +    The scale is based on power of 2. It is used for measurement of memory size.
> >
> > It might be useful to give an example of how to use the exponent field
> > in practice.
> >
> Those examples where we discuss ``flags`` field also cover the usage
> of exponent field.
Will add an example here too.
> > > +
> > > +The ``size`` field is the number of values of this statistics data. It is in the
> > > +unit of ``unsigned long`` for VCPU or ``__u64`` for VM.
> > > +
> > > +The ``unused1`` and ``unused2`` fields are reserved for future
> > > +support for other types of statistics data, like log/linear histogram.
> > > +
> > > +The ``name`` field points to the name string of the statistics data. The name
> > > +string starts at the end of ``struct kvm_stats_desc``.
> > > +The maximum length (including trailing '\0') is indicated by ``name_size``
> > > +in ``struct kvm_stats_header``.
> > > +
> > > +The Stats Data block contains an array of data values of type ``struct
> > > +kvm_vm_stats_data`` or ``struct kvm_vcpu_stats_data``. It would be read by
> > > +user space periodically to pull statistics data.
> > > +The order of data value in Stats Data block is the same as the order of
> > > +descriptors in Descriptors block.
> > > +  * Statistics data for VM::
> > > +
> > > +       struct kvm_vm_stats_data {
> > > +               unsigned long value[0];
> > > +       };
> > > +
> > > +  * Statistics data for VCPU::
> > > +
> > > +       struct kvm_vcpu_stats_data {
> > > +               __u64 value[0];
> > > +       };
> > > +
> > >  5. The kvm_run structure
> > >  ========================
> > >
> > > @@ -6891,3 +7054,11 @@ This capability is always enabled.
> > >  This capability indicates that the KVM virtual PTP service is
> > >  supported in the host. A VMM can check whether the service is
> > >  available to the guest on migration.
> > > +
> > > +8.33 KVM_CAP_STATS_BINARY_FD
> > > +----------------------------
> > > +
> > > +:Architectures: all
> > > +
> > > +This capability indicates the feature that user space can create get a file
> > > +descriptor for every VM and VCPU to read statistics data in binary format.
> > > --
> > > 2.31.1.751.gd2f1c929bd-goog
> > >
> Thanks,
> Jing
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
